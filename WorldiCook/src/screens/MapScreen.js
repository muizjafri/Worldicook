// src/screens/MapScreen.js
import React, { useEffect, useMemo, useRef, useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ActivityIndicator } from 'react-native';
import MapView, { Marker, PROVIDER_DEFAULT } from 'react-native-maps';
import { api } from '../services/api';
import { colors } from '../constants/colors';

const WORLD_REGION = {
  latitude: 20,
  longitude: 10,
  latitudeDelta: 90,
  longitudeDelta: 170,
};

const CONTINENT_LABELS = [
  { name: 'North America', latitude: 45, longitude: -100 },
  { name: 'South America', latitude: -15, longitude: -60 },
  { name: 'Europe', latitude: 54, longitude: 25 },
  { name: 'Africa', latitude: 6, longitude: 21 },
  { name: 'Asia', latitude: 34, longitude: 100 },
  { name: 'Oceania', latitude: -25, longitude: 140 },
];

function tierForRegion(region) {
  if (!region) return 'world';
  if (region.longitudeDelta > 60) return 'world';
  if (region.longitudeDelta > 15) return 'continent';
  return 'country';
}

export default function MapScreen({ route, navigation }) {
  const mapRef = useRef(null);
  const [countries, setCountries] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [zoomTier, setZoomTier] = useState('world');
  const [selectedCountry, setSelectedCountry] = useState(null);

  useEffect(() => {
    let cancelled = false;
    api
      .getCountries()
      .then((data) => {
        if (!cancelled) setCountries(data);
      })
      .catch((err) => {
        if (!cancelled) setError(err.message);
      })
      .finally(() => {
        if (!cancelled) setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, []);

  const focusIso = route?.params?.focusIso;
  useEffect(() => {
    if (!focusIso || countries.length === 0) return;
    const target = countries.find((c) => c.iso_code === focusIso);
    if (!target) return;
    const timer = setTimeout(() => {
      mapRef.current?.animateToRegion(
        {
          latitude: target.latitude,
          longitude: target.longitude,
          latitudeDelta: 8,
          longitudeDelta: 8,
        },
        1200
      );
    }, 400);
    return () => clearTimeout(timer);
  }, [focusIso, countries]);

  function handleRegionChangeComplete(region) {
    setZoomTier(tierForRegion(region));
  }

  function handleMarkerPress(country) {
    setSelectedCountry(country);
  }

  function handleExplore() {
    if (!selectedCountry) return;
    const iso = selectedCountry.iso_code;
    setSelectedCountry(null);
    navigation.navigate('Country', { iso });
  }

  const showCountryMarkers = zoomTier !== 'world';
  const showLabels = zoomTier === 'country';

  return (
    <View style={styles.container}>
      <MapView
        ref={mapRef}
        style={StyleSheet.absoluteFill}
        provider={PROVIDER_DEFAULT}
        initialRegion={WORLD_REGION}
        onRegionChangeComplete={handleRegionChangeComplete}
        showsPointsOfInterest={false}
        showsBuildings={false}
        showsTraffic={false}
        showsIndoors={false}
        showsCompass={false}
        toolbarEnabled={false}
        onPress={() => setSelectedCountry(null)}
      >
        {zoomTier === 'world' &&
          CONTINENT_LABELS.map((c) => (
            <Marker key={c.name} coordinate={c} anchor={{ x: 0.5, y: 0.5 }} tappable={false}>
              <View style={styles.continentLabel}>
                <Text style={styles.continentLabelText}>{c.name}</Text>
              </View>
            </Marker>
          ))}

        {showCountryMarkers &&
          countries.map((c) => (
            <Marker
              key={c.iso_code}
              coordinate={{ latitude: c.latitude, longitude: c.longitude }}
              anchor={{ x: 0.5, y: 0.5 }}
              onPress={() => handleMarkerPress(c)}
            >
              <View style={styles.countryMarker}>
                <Text style={styles.countryFlag}>{c.flag_emoji}</Text>
                {showLabels && <Text style={styles.countryLabel}>{c.name}</Text>}
              </View>
            </Marker>
          ))}
      </MapView>

      {loading && (
        <View style={styles.loadingOverlay}>
          <ActivityIndicator color={colors.accent} />
        </View>
      )}

      {error && (
        <View style={styles.errorBanner}>
          <Text style={styles.errorText}>Couldn't reach the API: {error}</Text>
        </View>
      )}

      {selectedCountry && (
        <View style={styles.infoCard}>
          <Text style={styles.infoFlag}>{selectedCountry.flag_emoji}</Text>
          <View style={{ flex: 1 }}>
            <Text style={styles.infoName}>{selectedCountry.name}</Text>
            <Text style={styles.infoRegion}>{selectedCountry.region}</Text>
          </View>
          <TouchableOpacity style={styles.exploreButton} onPress={handleExplore} activeOpacity={0.85}>
            <Text style={styles.exploreButtonText}>Explore {selectedCountry.name} Food</Text>
          </TouchableOpacity>
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: colors.background },
  loadingOverlay: {
    position: 'absolute',
    top: 20,
    left: 0,
    right: 0,
    alignItems: 'center',
  },
  errorBanner: {
    position: 'absolute',
    top: 20,
    left: 20,
    right: 20,
    backgroundColor: '#3A1F22',
    borderRadius: 10,
    padding: 10,
  },
  errorText: { color: '#FFD3D3', fontSize: 12 },
  continentLabel: {
    backgroundColor: 'rgba(22,27,41,0.85)',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 10,
  },
  continentLabelText: { color: colors.textPrimary, fontWeight: '700', fontSize: 13 },
  countryMarker: { alignItems: 'center' },
  countryFlag: { fontSize: 26 },
  countryLabel: {
    marginTop: 2,
    backgroundColor: 'rgba(22,27,41,0.9)',
    color: colors.textPrimary,
    fontSize: 11,
    fontWeight: '700',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 6,
    overflow: 'hidden',
  },
  infoCard: {
    position: 'absolute',
    left: 16,
    right: 16,
    bottom: 24,
    backgroundColor: colors.surface,
    borderRadius: 18,
    padding: 14,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.3,
    shadowRadius: 10,
    shadowOffset: { width: 0, height: 4 },
    elevation: 6,
  },
  infoFlag: { fontSize: 30, marginRight: 12 },
  infoName: { color: colors.textPrimary, fontWeight: '800', fontSize: 16 },
  infoRegion: { color: colors.textMuted, fontSize: 12, marginTop: 1 },
  exploreButton: {
    backgroundColor: colors.accent,
    borderRadius: 12,
    paddingHorizontal: 12,
    paddingVertical: 10,
  },
  exploreButtonText: { color: '#fff', fontWeight: '700', fontSize: 12 },
});

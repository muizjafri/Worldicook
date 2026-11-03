import React, { useEffect, useRef, useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ActivityIndicator, Animated, Dimensions } from 'react-native';
import MapView, { Marker, PROVIDER_DEFAULT } from 'react-native-maps';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { api } from '../services/api';
import { colors } from '../constants/colors';

const { height: SCREEN_HEIGHT } = Dimensions.get('window');

const WORLD_REGION = {
  latitude: 20,
  longitude: 10,
  latitudeDelta: 90,
  longitudeDelta: 170,
};

export default function HomeScreen({ navigation }) {
  const insets = useSafeAreaInsets();
  const mapRef = useRef(null);
  const cardTranslateY = useRef(new Animated.Value(SCREEN_HEIGHT)).current;
  const markerOpacity = useRef(new Animated.Value(0)).current;
  const hasAnimated = useRef(false);

  const [daily, setDaily] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [mapReady, setMapReady] = useState(false);
  const [showMarker, setShowMarker] = useState(false);

  useEffect(() => {
    let cancelled = false;
    api
      .getDailyCountry()
      .then((data) => {
        if (!cancelled) setDaily(data);
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

  useEffect(() => {
    if (!mapReady || !daily || hasAnimated.current) return;
    hasAnimated.current = true;
    playIntro();
  }, [mapReady, daily]);

  function playIntro() {
    const spinCenter = { latitude: WORLD_REGION.latitude, longitude: WORLD_REGION.longitude };
    const spinStepDuration = 650;

    mapRef.current?.animateCamera(
      { center: spinCenter, heading: 130, altitude: 12000000 },
      { duration: spinStepDuration }
    );
    setTimeout(() => {
      mapRef.current?.animateCamera(
        { center: spinCenter, heading: 250 },
        { duration: spinStepDuration }
      );
    }, spinStepDuration);
    setTimeout(() => {
      mapRef.current?.animateCamera(
        { center: spinCenter, heading: 360 },
        { duration: spinStepDuration }
      );
    }, spinStepDuration * 2);

    setTimeout(() => {
      mapRef.current?.animateToRegion(
        {
          latitude: daily.latitude,
          longitude: daily.longitude,
          latitudeDelta: 12,
          longitudeDelta: 12,
        },
        1400
      );
    }, spinStepDuration * 3);

    setTimeout(() => {
      setShowMarker(true);
      Animated.timing(markerOpacity, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }).start();
    }, spinStepDuration * 3 + 1100);

    setTimeout(() => {
      Animated.timing(cardTranslateY, {
        toValue: 0,
        duration: 420,
        useNativeDriver: true,
      }).start();
    }, spinStepDuration * 3 + 1400);
  }

  function handleExplore() {
    navigation.navigate('Map', { focusIso: daily.iso_code });
  }

  function handleSeeFeatured() {
    if (daily.featuredDish) {
      navigation.navigate('Dish', { id: daily.featuredDish.id });
    }
  }

  return (
    <View style={styles.container}>
      <MapView
        ref={mapRef}
        style={StyleSheet.absoluteFill}
        provider={PROVIDER_DEFAULT}
        initialRegion={WORLD_REGION}
        onMapReady={() => setMapReady(true)}
        scrollEnabled={false}
        zoomEnabled={false}
        rotateEnabled={false}
        pitchEnabled={false}
        showsPointsOfInterest={false}
        showsBuildings={false}
        showsTraffic={false}
        showsCompass={false}
        toolbarEnabled={false}
      >
        {showMarker && daily && (
          <Marker coordinate={{ latitude: daily.latitude, longitude: daily.longitude }} anchor={{ x: 0.5, y: 0.5 }}>
            <Animated.View style={{ opacity: markerOpacity }}>
              <View style={styles.marker}>
                <Text style={styles.markerFlag}>{daily.flag_emoji}</Text>
              </View>
            </Animated.View>
          </Marker>
        )}
      </MapView>

      <View pointerEvents="none" style={[styles.titleWrap, { top: insets.top + 8 }]}>
        <Text style={styles.appTitle}>WorldiCook</Text>
        <Text style={styles.subtitle}>Today's Journey</Text>
      </View>

      {(loading || !mapReady) && !error && (
        <View style={styles.loadingOverlay}>
          <ActivityIndicator color={colors.accent} />
        </View>
      )}

      {error && (
        <View style={[styles.errorBanner, { top: insets.top + 70 }]}>
          <Text style={styles.errorText}>
            Couldn't reach the API ({error}). Is the server running and is
            EXPO_PUBLIC_API_BASE_URL set to your computer's LAN IP?
          </Text>
        </View>
      )}

      {daily && (
        <Animated.View
          style={[
            styles.card,
            { paddingBottom: 28 + insets.bottom, transform: [{ translateY: cardTranslateY }] },
          ]}
        >
          <Text style={styles.flag}>{daily.flag_emoji}</Text>
          <Text style={styles.countryName}>{daily.name}</Text>
          <Text style={styles.region}>{daily.region}</Text>
          <Text style={styles.description}>{daily.description}</Text>

          {daily.featuredDish && (
            <TouchableOpacity style={styles.featuredDish} onPress={handleSeeFeatured} activeOpacity={0.8}>
              <Text style={styles.featuredEmoji}>{daily.featuredDish.emoji}</Text>
              <View style={{ flex: 1 }}>
                <Text style={styles.featuredLabel}>Featured dish</Text>
                <Text style={styles.featuredName}>{daily.featuredDish.name}</Text>
              </View>
              <Text style={styles.chevron}>›</Text>
            </TouchableOpacity>
          )}

          <TouchableOpacity style={styles.exploreButton} onPress={handleExplore} activeOpacity={0.85}>
            <Text style={styles.exploreButtonText}>🌎 Explore on the Map</Text>
          </TouchableOpacity>
        </Animated.View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: colors.background },
  titleWrap: {
    position: 'absolute',
    left: 0,
    right: 0,
    alignItems: 'center',
  },
  appTitle: { fontSize: 20, fontWeight: '800', color: colors.textPrimary, letterSpacing: 0.5 },
  subtitle: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  loadingOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    alignItems: 'center',
    justifyContent: 'center',
  },
  errorBanner: {
    position: 'absolute',
    left: 20,
    right: 20,
    backgroundColor: '#3A1F22',
    borderRadius: 10,
    padding: 12,
  },
  errorText: { color: '#FFD3D3', fontSize: 12, lineHeight: 18 },
  marker: {
    width: 46,
    height: 46,
    borderRadius: 23,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 3,
    borderColor: colors.gold,
  },
  markerFlag: { fontSize: 22 },
  card: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: colors.surface,
    borderTopLeftRadius: 28,
    borderTopRightRadius: 28,
    paddingTop: 28,
    paddingHorizontal: 24,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.3,
    shadowRadius: 14,
    shadowOffset: { width: 0, height: -4 },
    elevation: 10,
  },
  flag: { fontSize: 48 },
  countryName: { fontSize: 24, fontWeight: '800', color: colors.textPrimary, marginTop: 6 },
  region: { fontSize: 13, color: colors.teal, fontWeight: '600', marginTop: 2, marginBottom: 12 },
  description: { fontSize: 14, color: colors.textSecondary, textAlign: 'center', lineHeight: 20 },
  featuredDish: {
    flexDirection: 'row',
    alignItems: 'center',
    width: '100%',
    backgroundColor: colors.surfaceAlt,
    borderRadius: 14,
    padding: 12,
    marginTop: 18,
  },
  featuredEmoji: { fontSize: 26, marginRight: 10 },
  featuredLabel: { fontSize: 11, color: colors.textMuted },
  featuredName: { fontSize: 15, color: colors.textPrimary, fontWeight: '700' },
  chevron: { fontSize: 20, color: colors.textMuted },
  exploreButton: {
    marginTop: 18,
    backgroundColor: colors.accent,
    borderRadius: 14,
    paddingVertical: 13,
    paddingHorizontal: 26,
  },
  exploreButtonText: { color: '#fff', fontWeight: '700', fontSize: 14 },
});
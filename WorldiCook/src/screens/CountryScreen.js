// src/screens/CountryScreen.js
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ScrollView, ActivityIndicator } from 'react-native';
import { api } from '../services/api';
import { colors } from '../constants/colors';
import DishListItem from '../components/DishListItem';

export default function CountryScreen({ route, navigation }) {
  const { iso } = route.params;
  const [country, setCountry] = useState(null);
  const [dishes, setDishes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    Promise.all([api.getCountry(iso), api.getCountryDishes(iso)])
      .then(([countryData, dishesData]) => {
        if (cancelled) return;
        setCountry(countryData);
        setDishes(dishesData);
        navigation.setOptions({ title: countryData.name });
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
  }, [iso]);

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator color={colors.accent} />
      </View>
    );
  }

  if (error || !country) {
    return (
      <View style={styles.centered}>
        <Text style={styles.error}>Couldn't load this country ({error}).</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.screen} contentContainerStyle={{ paddingBottom: 40 }}>
      <View style={styles.header}>
        <Text style={styles.flag}>{country.flag_emoji}</Text>
        <Text style={styles.name}>{country.name}</Text>
        <Text style={styles.region}>{country.region}</Text>
      </View>

      <Text style={styles.description}>{country.description}</Text>

      {country.food_history && (
        <>
          <Text style={styles.sectionLabel}>Food Culture & History</Text>
          <Text style={styles.description}>{country.food_history}</Text>
        </>
      )}

      <Text style={styles.sectionLabel}>Featured Dishes</Text>
      <View style={styles.dishList}>
        {dishes.map((dish) => (
          <DishListItem key={dish.id} dish={dish} onPress={() => navigation.navigate('Dish', { id: dish.id })} />
        ))}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background, paddingHorizontal: 20 },
  centered: { flex: 1, backgroundColor: colors.background, alignItems: 'center', justifyContent: 'center' },
  error: { color: '#FFB4B4', textAlign: 'center', paddingHorizontal: 30 },
  header: { alignItems: 'center', marginTop: 16, marginBottom: 12 },
  flag: { fontSize: 48 },
  name: { fontSize: 24, fontWeight: '800', color: colors.textPrimary, marginTop: 4 },
  region: { fontSize: 13, color: colors.teal, fontWeight: '600', marginTop: 2 },
  description: { fontSize: 14, color: colors.textSecondary, lineHeight: 20, marginBottom: 12 },
  sectionLabel: {
    fontSize: 12,
    fontWeight: '800',
    color: colors.teal,
    letterSpacing: 0.6,
    marginTop: 16,
    marginBottom: 8,
  },
  dishList: { marginBottom: 10 },
});

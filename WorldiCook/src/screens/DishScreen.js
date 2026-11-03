// src/screens/DishScreen.js
import React, { useEffect, useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ScrollView, ActivityIndicator } from 'react-native';
import { api } from '../services/api';
import { colors } from '../constants/colors';
import IngredientList from '../components/IngredientList';

const CATEGORY_CONTEXT = {
  'traditional dish': 'A traditional dish, commonly passed down through families.',
  'regional specialty': 'A specialty most associated with one particular region.',
  'street food': 'Commonly sold and eaten as street food.',
  'dessert': 'Typically served as a dessert.',
  'drink': 'Typically served as a drink.',
  'celebration food': 'Often made for celebrations and special occasions.',
  'everyday food': 'A common, everyday dish.',
};

export default function DishScreen({ route, navigation }) {
  const { id } = route.params;
  const [dish, setDish] = useState(null);
  const [ingredients, setIngredients] = useState([]);
  const [sources, setSources] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    Promise.all([api.getDish(id), api.getDishIngredients(id), api.getDishSources(id)])
      .then(([dishData, ingredientsData, sourcesData]) => {
        if (cancelled) return;
        setDish(dishData);
        setIngredients(ingredientsData);
        setSources(sourcesData);
        navigation.setOptions({ title: dishData.name });
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
  }, [id]);

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator color={colors.accent} />
      </View>
    );
  }

  if (error || !dish) {
    return (
      <View style={styles.centered}>
        <Text style={styles.error}>Couldn't load this dish ({error}).</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.screen} contentContainerStyle={{ paddingBottom: 40 }}>
      <View style={styles.header}>
        <Text style={styles.emoji}>{dish.emoji}</Text>
        <Text style={styles.name}>{dish.name}</Text>
        <Text style={styles.country}>
          {dish.flag_emoji} {dish.country_name}
        </Text>
      </View>

      <Text style={styles.sectionLabel}>About the Dish</Text>
      <Text style={styles.body}>{dish.description}</Text>

      {dish.history && (
        <>
          <Text style={styles.sectionLabel}>History</Text>
          <Text style={styles.body}>{dish.history}</Text>
        </>
      )}

      <Text style={styles.sectionLabel}>Where It's Popular</Text>
      <Text style={styles.body}>
        {dish.country_name}
        {dish.region ? ` — ${dish.region}` : ''}
      </Text>

      <Text style={styles.sectionLabel}>When It's Commonly Eaten</Text>
      <Text style={styles.body}>{CATEGORY_CONTEXT[dish.category] || dish.category}</Text>

      <Text style={styles.sectionLabel}>Ingredients</Text>
      <IngredientList ingredients={ingredients} />

      {dish.cultural_significance && (
        <>
          <Text style={styles.sectionLabel}>Cultural Context</Text>
          <Text style={styles.body}>{dish.cultural_significance}</Text>
        </>
      )}

      {sources.length > 0 && (
        <>
          <Text style={styles.sectionLabel}>Sources</Text>
          {sources.map((s, i) => (
            <Text key={i} style={styles.sourceLine}>
              {s.title}{s.publisher ? ` — ${s.publisher}` : ''}
            </Text>
          ))}
        </>
      )}

      <TouchableOpacity
        style={styles.recipeButton}
        activeOpacity={0.85}
        onPress={() => navigation.navigate('Recipe', { id: dish.id, name: dish.name })}
      >
        <Text style={styles.recipeButtonText}>👨‍🍳 View Full Recipe</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background, paddingHorizontal: 20 },
  centered: { flex: 1, backgroundColor: colors.background, alignItems: 'center', justifyContent: 'center' },
  error: { color: '#FFB4B4', textAlign: 'center', paddingHorizontal: 30 },
  header: { alignItems: 'center', marginTop: 12, marginBottom: 8 },
  emoji: { fontSize: 44 },
  name: { fontSize: 24, fontWeight: '800', color: colors.textPrimary, marginTop: 4 },
  country: { fontSize: 13, color: colors.teal, fontWeight: '600', marginTop: 2 },
  sectionLabel: {
    fontSize: 12,
    fontWeight: '800',
    color: colors.teal,
    letterSpacing: 0.6,
    marginTop: 16,
    marginBottom: 6,
  },
  body: { fontSize: 14, color: colors.textSecondary, lineHeight: 20 },
  sourceLine: { fontSize: 12, color: colors.textMuted, lineHeight: 18 },
  recipeButton: {
    marginTop: 24,
    backgroundColor: colors.accentWarm,
    borderRadius: 14,
    paddingVertical: 14,
    alignItems: 'center',
  },
  recipeButtonText: { color: '#fff', fontWeight: '700', fontSize: 15 },
});

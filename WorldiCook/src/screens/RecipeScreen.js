// src/screens/RecipeScreen.js
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ScrollView, ActivityIndicator } from 'react-native';
import { api } from '../services/api';
import { colors } from '../constants/colors';
import IngredientList from '../components/IngredientList';
import RecipeSteps from '../components/RecipeSteps';

export default function RecipeScreen({ route, navigation }) {
  const { id, name } = route.params;
  const [dish, setDish] = useState(null);
  const [ingredients, setIngredients] = useState([]);
  const [steps, setSteps] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    navigation.setOptions({ title: name ? `Cook ${name}` : 'Recipe' });
    let cancelled = false;
    Promise.all([api.getDish(id), api.getDishIngredients(id), api.getDishSteps(id)])
      .then(([dishData, ingredientsData, stepsData]) => {
        if (cancelled) return;
        setDish(dishData);
        setIngredients(ingredientsData);
        setSteps(stepsData);
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
        <Text style={styles.error}>Couldn't load this recipe ({error}).</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.screen} contentContainerStyle={{ paddingBottom: 40 }}>
      <View style={styles.metaRow}>
        <View style={styles.metaBox}>
          <Text style={styles.metaLabel}>Prep</Text>
          <Text style={styles.metaValue}>{dish.prep_time}</Text>
        </View>
        <View style={styles.metaBox}>
          <Text style={styles.metaLabel}>Cook</Text>
          <Text style={styles.metaValue}>{dish.cook_time}</Text>
        </View>
        <View style={styles.metaBox}>
          <Text style={styles.metaLabel}>Serves</Text>
          <Text style={styles.metaValue}>{dish.servings}</Text>
        </View>
        <View style={styles.metaBox}>
          <Text style={styles.metaLabel}>Difficulty</Text>
          <Text style={styles.metaValue}>{dish.difficulty}</Text>
        </View>
      </View>

      <Text style={styles.sectionLabel}>Ingredients</Text>
      <IngredientList ingredients={ingredients} />

      <Text style={[styles.sectionLabel, { marginTop: 20 }]}>Instructions</Text>
      <RecipeSteps steps={steps} />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background, paddingHorizontal: 20, paddingTop: 16 },
  centered: { flex: 1, backgroundColor: colors.background, alignItems: 'center', justifyContent: 'center' },
  error: { color: '#FFB4B4', textAlign: 'center', paddingHorizontal: 30 },
  metaRow: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 16 },
  metaBox: {
    flex: 1,
    backgroundColor: colors.surfaceAlt,
    borderRadius: 12,
    paddingVertical: 10,
    marginHorizontal: 3,
    alignItems: 'center',
  },
  metaLabel: { fontSize: 10, color: colors.textMuted },
  metaValue: { fontSize: 12, fontWeight: '700', color: colors.textPrimary, marginTop: 2, textAlign: 'center' },
  sectionLabel: { fontSize: 12, fontWeight: '800', color: colors.teal, letterSpacing: 0.6, marginBottom: 8 },
});

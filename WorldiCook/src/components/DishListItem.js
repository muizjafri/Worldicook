// src/components/DishListItem.js
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { colors } from '../constants/colors';

const CATEGORY_LABELS = {
  'traditional dish': 'Traditional',
  'regional specialty': 'Regional',
  'street food': 'Street Food',
  'dessert': 'Dessert',
  'drink': 'Drink',
  'celebration food': 'Celebration',
  'everyday food': 'Everyday',
};

export default function DishListItem({ dish, onPress }) {
  return (
    <TouchableOpacity style={styles.row} activeOpacity={0.75} onPress={onPress}>
      <Text style={styles.emoji}>{dish.emoji}</Text>
      <View style={{ flex: 1 }}>
        <Text style={styles.name}>{dish.name}</Text>
        <Text style={styles.category}>{CATEGORY_LABELS[dish.category] || dish.category}</Text>
      </View>
      <Text style={styles.chevron}>›</Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  emoji: { fontSize: 24, marginRight: 12 },
  name: { fontSize: 16, color: colors.textPrimary, fontWeight: '700' },
  category: { fontSize: 12, color: colors.teal, marginTop: 2 },
  chevron: { fontSize: 20, color: colors.textMuted },
});

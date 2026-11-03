// src/components/IngredientList.js
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors } from '../constants/colors';

function formatLine(item) {
  const parts = [];
  if (item.quantity) parts.push(item.quantity);
  if (item.unit) parts.push(item.unit);
  const amount = parts.join(' ');
  let line = amount ? `${amount} ${item.name}` : item.name;
  if (item.notes) line += ` (${item.notes})`;
  return line;
}

export default function IngredientList({ ingredients }) {
  return (
    <View>
      {ingredients.map((item, i) => (
        <Text key={i} style={styles.line}>
          • {formatLine(item)}
        </Text>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  line: { fontSize: 13, color: colors.textSecondary, lineHeight: 20 },
});

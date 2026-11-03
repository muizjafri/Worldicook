// src/components/RecipeSteps.js
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors } from '../constants/colors';

export default function RecipeSteps({ steps }) {
  return (
    <View>
      {steps.map((step) => (
        <View key={step.step_number} style={styles.row}>
          <View style={styles.circle}>
            <Text style={styles.circleText}>{step.step_number}</Text>
          </View>
          <Text style={styles.instruction}>{step.instruction}</Text>
        </View>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  row: { flexDirection: 'row', marginBottom: 12 },
  circle: {
    width: 22,
    height: 22,
    borderRadius: 11,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 10,
    marginTop: 1,
  },
  circleText: { color: '#fff', fontSize: 11, fontWeight: '700' },
  instruction: { flex: 1, fontSize: 13, color: colors.textSecondary, lineHeight: 20 },
});

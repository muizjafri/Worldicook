// src/screens/SearchScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, FlatList, ActivityIndicator } from 'react-native';
import { api } from '../services/api';
import { colors } from '../constants/colors';

export default function SearchScreen({ navigation }) {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState({ countries: [], dishes: [] });
  const [loading, setLoading] = useState(false);

  let debounceTimer = null;

  function handleChangeText(text) {
    setQuery(text);
    clearTimeout(debounceTimer);
    if (!text.trim()) {
      setResults({ countries: [], dishes: [] });
      return;
    }
    setLoading(true);
    debounceTimer = setTimeout(() => {
      api
        .search(text)
        .then(setResults)
        .catch(() => setResults({ countries: [], dishes: [] }))
        .finally(() => setLoading(false));
    }, 300);
  }

  const combined = [
    ...results.countries.map((c) => ({ type: 'country', ...c })),
    ...results.dishes.map((d) => ({ type: 'dish', ...d })),
  ];

  function handlePress(item) {
    if (item.type === 'country') {
      navigation.navigate('Country', { iso: item.iso_code });
    } else {
      navigation.navigate('Dish', { id: item.id });
    }
  }

  return (
    <View style={styles.screen}>
      <TextInput
        style={styles.input}
        value={query}
        onChangeText={handleChangeText}
        placeholder="Search countries or dishes..."
        placeholderTextColor={colors.textMuted}
        autoCorrect={false}
      />

      {loading && <ActivityIndicator color={colors.accent} style={{ marginTop: 20 }} />}

      <FlatList
        data={combined}
        keyExtractor={(item, i) => `${item.type}-${item.id || item.iso_code}-${i}`}
        renderItem={({ item }) => (
          <TouchableOpacity style={styles.row} onPress={() => handlePress(item)} activeOpacity={0.75}>
            <Text style={styles.emoji}>{item.flag_emoji || item.emoji}</Text>
            <View style={{ flex: 1 }}>
              <Text style={styles.name}>{item.name}</Text>
              <Text style={styles.meta}>
                {item.type === 'country' ? 'Country' : `Dish · ${item.country_name}`}
              </Text>
            </View>
          </TouchableOpacity>
        )}
        ListEmptyComponent={
          query.trim() && !loading ? <Text style={styles.empty}>No matches yet.</Text> : null
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background, paddingHorizontal: 20, paddingTop: 16 },
  input: {
    backgroundColor: colors.surface,
    borderRadius: 14,
    paddingHorizontal: 14,
    paddingVertical: 12,
    color: colors.textPrimary,
    fontSize: 15,
    borderWidth: 1,
    borderColor: colors.border,
    marginBottom: 12,
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  emoji: { fontSize: 22, marginRight: 12 },
  name: { fontSize: 15, color: colors.textPrimary, fontWeight: '700' },
  meta: { fontSize: 12, color: colors.textMuted, marginTop: 1 },
  empty: { color: colors.textMuted, textAlign: 'center', marginTop: 30 },
});

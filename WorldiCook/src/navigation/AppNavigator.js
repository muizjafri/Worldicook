// src/navigation/AppNavigator.js
import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Text } from 'react-native';

import HomeScreen from '../screens/HomeScreen';
import MapScreen from '../screens/MapScreen';
import SearchScreen from '../screens/SearchScreen';
import CountryScreen from '../screens/CountryScreen';
import DishScreen from '../screens/DishScreen';
import RecipeScreen from '../screens/RecipeScreen';
import { colors } from '../constants/colors';

const Tab = createBottomTabNavigator();
const HomeStack = createNativeStackNavigator();
const MapStack = createNativeStackNavigator();
const SearchStack = createNativeStackNavigator();

const screenOptions = {
  headerStyle: { backgroundColor: colors.background },
  headerTintColor: colors.textPrimary,
  headerShadowVisible: false,
  contentStyle: { backgroundColor: colors.background },
};

function addSharedScreens(Stack) {
  return (
    <>
      <Stack.Screen name="Country" component={CountryScreen} options={{ title: '' }} />
      <Stack.Screen name="Dish" component={DishScreen} options={{ title: '' }} />
      <Stack.Screen name="Recipe" component={RecipeScreen} options={{ title: 'Recipe' }} />
    </>
  );
}

function HomeStackScreen() {
  return (
    <HomeStack.Navigator screenOptions={screenOptions}>
      <HomeStack.Screen name="HomeMain" component={HomeScreen} options={{ headerShown: false }} />
      {addSharedScreens(HomeStack)}
    </HomeStack.Navigator>
  );
}

function MapStackScreen() {
  return (
    <MapStack.Navigator screenOptions={screenOptions}>
      <MapStack.Screen name="MapMain" component={MapScreen} options={{ headerShown: false }} />
      {addSharedScreens(MapStack)}
    </MapStack.Navigator>
  );
}

function SearchStackScreen() {
  return (
    <SearchStack.Navigator screenOptions={screenOptions}>
      <SearchStack.Screen name="SearchMain" component={SearchScreen} options={{ title: 'Search' }} />
      {addSharedScreens(SearchStack)}
    </SearchStack.Navigator>
  );
}

const TAB_ICONS = { Home: '🌅', Map: '🌎', Search: '🔍' };

export default function AppNavigator() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarActiveTintColor: colors.accent,
        tabBarInactiveTintColor: colors.textMuted,
        tabBarStyle: { backgroundColor: colors.surface, borderTopColor: colors.border },
        tabBarIcon: () => <Text style={{ fontSize: 18 }}>{TAB_ICONS[route.name]}</Text>,
      })}
    >
      <Tab.Screen name="Home" component={HomeStackScreen} />
      <Tab.Screen name="Map" component={MapStackScreen} options={{ title: 'Explore' }} />
      <Tab.Screen name="Search" component={SearchStackScreen} />
    </Tab.Navigator>
  );
}

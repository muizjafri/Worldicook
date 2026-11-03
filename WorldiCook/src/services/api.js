// src/services/api.js
import { API_BASE_URL } from '../constants/config';

async function request(path) {
  const res = await fetch(`${API_BASE_URL}${path}`);
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(body.error || `Request failed: ${path} (${res.status})`);
  }
  return res.json();
}

export const api = {
  getCountries: () => request('/countries'),
  getCountry: (iso) => request(`/countries/${iso}`),
  getCountryDishes: (iso) => request(`/countries/${iso}/dishes`),
  getDish: (id) => request(`/dishes/${id}`),
  getDishIngredients: (id) => request(`/dishes/${id}/ingredients`),
  getDishSteps: (id) => request(`/dishes/${id}/steps`),
  getDishSources: (id) => request(`/dishes/${id}/sources`),
  getDailyCountry: () => request('/daily-country'),
  search: (q) => request(`/search?q=${encodeURIComponent(q)}`),
};

-- database/002_seed_countries.sql
--
-- Seed data for supported countries. Add more over time by appending
-- new rows to this same VALUES list and re-running the whole file —
-- ON CONFLICT DO NOTHING means existing countries are safely skipped.

INSERT INTO countries (name, iso_code, continent, region, flag_emoji, description, food_history, latitude, longitude)
VALUES
  (
    'India', 'IN', 'Asia', 'South Asia', '🇮🇳',
    'Indian cuisine includes a wide variety of regional dishes, ingredients, and cooking traditions — it is not one single cuisine but many, shaped by geography, climate, and centuries of regional history.',
    'Indian food history reflects influences from Persian, Mughal, and various regional South Asian traditions, along with distinct local ingredients and techniques that vary enormously between the north, south, east, and west of the country.',
    20.5937, 78.9629
  ),
  (
    'Pakistan', 'PK', 'Asia', 'South Asia', '🇵🇰',
    'Pakistani cuisine features rich, spiced dishes shaped by centuries of regional history and traditions shared across the broader South Asian region.',
    'Much of Pakistani cuisine traces to Mughal-era cooking traditions from the Indian subcontinent, later shaped by regional Punjabi, Sindhi, and Pashtun influences.',
    30.3753, 69.3451
  ),
  (
    'Egypt', 'EG', 'Africa', 'North Africa', '🇪🇬',
    'Egyptian cuisine blends ancient traditions with influences from across the Mediterranean and Middle East, built around staples like legumes, rice, and bread.',
    'Some Egyptian dishes, like ful medames, are believed to have very old roots in the region, while others reflect more recent Ottoman and Mediterranean influence.',
    26.8206, 30.8025
  ),
  (
    'Russia', 'RU', 'Europe', 'Eastern Europe', '🇷🇺',
    'Russian cuisine offers hearty, comforting dishes well suited to a cold climate, with many dishes shared across neighboring Eastern European food traditions.',
    'Russian food history includes strong traditions of preservation (pickling, fermenting) suited to long winters, and several dishes with disputed or shared origins across Eastern Europe.',
    61.5240, 105.3188
  ),
  (
    'Japan', 'JP', 'Asia', 'East Asia', '🇯🇵',
    'Japanese cuisine spans everything from delicate raw-fish preparations to hearty noodle soups, with a strong emphasis on seasonality and presentation.',
    'Many staples of Japanese food, such as soy sauce and noodle dishes, reflect historical exchange with China, later developed into distinctly Japanese forms over centuries.',
    36.2048, 138.2529
  ),
  (
    'China', 'CN', 'Asia', 'East Asia', '🇨🇳',
    'Chinese cuisine is enormously diverse, made up of many distinct regional culinary traditions rather than a single national cuisine.',
    'Regional Chinese cooking styles, such as Sichuan, Cantonese, and Hunan, developed largely independently based on local climate, geography, and available ingredients.',
    35.8617, 104.1954
  ),
  (
    'Morocco', 'MA', 'Africa', 'North Africa', '🇲🇦',
    'Moroccan cuisine blends Berber, Arab, and Mediterranean influences, often built around slow-cooked stews and shared communal dishes.',
    'Moroccan food history reflects centuries of trade across North Africa and the Mediterranean, along with Andalusian influence following historical migrations from Spain.',
    31.7917, -7.0926
  ),
  (
    'Nigeria', 'NG', 'Africa', 'West Africa', '🇳🇬',
    'Nigerian cuisine varies significantly by region and ethnic group, with hundreds of distinct dishes built around staples like rice, cassava, and yams.',
    'Nigerian food traditions reflect the country''s many ethnic groups, including Yoruba, Igbo, and Hausa culinary practices, each with their own staple dishes and techniques.',
    9.0820, 8.6753
  ),
  (
    'Mexico', 'MX', 'North America', 'North America', '🇲🇽',
    'Mexican cuisine combines Indigenous Mesoamerican ingredients and techniques with Spanish colonial influence, varying widely by region.',
    'Corn, beans, and chili peppers have been dietary staples in the region for thousands of years, predating European contact by a wide margin.',
    23.6345, -102.5528
  ),
  (
    'Italy', 'IT', 'Europe', 'Southern Europe', '🇮🇹',
    'Italian cuisine is strongly regional, with different areas of the country having distinct staple ingredients, pasta shapes, and cooking traditions.',
    'Many well-known Italian dishes are relatively regional or even local in origin, later spreading nationally and internationally through migration and trade.',
    41.8719, 12.5674
  ),
  (
    'Brazil', 'BR', 'South America', 'South America', '🇧🇷',
    'Brazilian cuisine reflects Indigenous, Portuguese, African, and immigrant influences, with strong regional variation across the country.',
    'Enslaved West Africans brought to Brazil during the colonial period introduced ingredients and techniques that remain central to several Brazilian dishes today.',
    -14.2350, -51.9253
  ),
  (
    'South Korea', 'KR', 'Asia', 'East Asia', '🇰🇷',
    'Korean cuisine is known for fermented staples, communal side dishes, and a balance of spicy, savory, and fermented flavors.',
    'Fermentation techniques used for staples like kimchi are believed to have developed as a way to preserve vegetables through cold winters.',
    35.9078, 127.7669
  ),
  (
    'Thailand', 'TH', 'Asia', 'Southeast Asia', '🇹🇭',
    'Thai cuisine balances sweet, sour, salty, and spicy flavors, with significant regional variation between the north, northeast, central, and south.',
    'Thai food history reflects influences from neighboring Chinese, Indian, and Southeast Asian culinary traditions, adapted with local ingredients over time.',
    15.8700, 100.9925
  ),
  (
    'Vietnam', 'VN', 'Asia', 'Southeast Asia', '🇻🇳',
    'Vietnamese cuisine emphasizes fresh herbs, broths, and a balance of flavors, with distinct northern, central, and southern regional styles.',
    'Vietnamese food history includes both Chinese influence from a long period of northern rule and French influence from the colonial era.',
    14.0583, 108.2772
  ),
  (
    'France', 'FR', 'Europe', 'Western Europe', '🇫🇷',
    'French cuisine is historically influential in Western cooking, with strong regional traditions alongside its well-known formal culinary techniques.',
    'French culinary technique became especially codified and influential starting in the 17th-19th centuries, shaping professional cooking well beyond France.',
    46.2276, 2.2137
  ),
  (
    'Spain', 'ES', 'Europe', 'Southern Europe', '🇪🇸',
    'Spanish cuisine varies considerably by region, from Mediterranean coastal dishes to heartier fare inland, often built around shared small plates.',
    'Centuries of Moorish rule in parts of Spain left a lasting influence on regional Spanish cuisine, including certain spices and ingredients.',
    40.4637, -3.7492
  ),
  (
    'Greece', 'GR', 'Europe', 'Southern Europe', '🇬🇷',
    'Greek cuisine centers on Mediterranean staples like olive oil, vegetables, and grilled or slow-cooked meats, with many dishes shared across the wider region.',
    'Greek food history reflects a long history of trade and exchange across the Mediterranean and with neighboring regions.',
    39.0742, 21.8243
  ),
  (
    'Turkey', 'TR', 'Asia', 'Middle East', '🇹🇷',
    'Turkish cuisine draws on Central Asian, Middle Eastern, Balkan, and Mediterranean influences, reflecting the country''s position spanning two continents.',
    'Ottoman-era palace cooking historically influenced many dishes now considered staples across Turkey and neighboring former Ottoman territories.',
    38.9637, 35.2433
  ),
  (
    'Lebanon', 'LB', 'Asia', 'Middle East', '🇱🇧',
    'Lebanese cuisine emphasizes fresh vegetables, legumes, and grilled meats, often served as part of a shared mezze spread.',
    'Many dishes considered part of Lebanese cuisine are shared across the wider Levant region, with similar versions found in neighboring countries.',
    33.8547, 35.8623
  ),
  (
    'Ethiopia', 'ET', 'Africa', 'East Africa', '🇪🇹',
    'Ethiopian cuisine is known for spiced stews served on a large sourdough flatbread, often eaten communally by hand.',
    'Ethiopian food traditions developed with limited external colonial influence compared to many other African nations, contributing to distinct regional staples.',
    9.1450, 40.4897
  ),
  (
    'Peru', 'PE', 'South America', 'South America', '🇵🇪',
    'Peruvian cuisine blends Indigenous Andean ingredients with Spanish, African, Chinese, and Japanese immigrant influences.',
    'Potatoes, of which Peru has enormous natural variety, are believed to have been first domesticated in the Andean region thousands of years ago.',
    -9.1900, -75.0152
  ),
  (
    'Indonesia', 'ID', 'Asia', 'Southeast Asia', '🇮🇩',
    'Indonesian cuisine varies enormously across its many islands and ethnic groups, with no single dish representing the whole country.',
    'Historical spice trade routes through the Indonesian archipelago shaped both local cuisine and, historically, global interest in the region.',
    -0.7893, 113.9213
  ),
  (
    'Germany', 'DE', 'Europe', 'Western Europe', '🇩🇪',
    'German cuisine varies by region, with hearty, often meat- and potato-based dishes alongside strong bread and sausage-making traditions.',
    'Regional German food traditions were historically shaped by the many separate states and kingdoms that existed before German unification.',
    51.1657, 10.4515
  ),
  (
    'United Kingdom', 'GB', 'Europe', 'Western Europe', '🇬🇧',
    'British cuisine includes distinct English, Scottish, Welsh, and Northern Irish traditions, along with dishes shaped by a long history of global trade and migration.',
    'Many dishes now considered characteristically British reflect centuries of ingredient trade and, more recently, culinary influence from South Asian and other immigrant communities.',
    55.3781, -3.4360
  )
ON CONFLICT (iso_code) DO NOTHING;
-- database/004_seed_sources.sql
--
-- IMPORTANT: sources are only added here for dishes where a real
-- source was actually looked up (Nihari, Haleem, Fattah, during this
-- project's research). The other 13 dishes intentionally have NO
-- rows here yet — do not treat their absence as an oversight to
-- silently fill in with invented citations. Add real sources for
-- them the same way, one at a time, as you verify them.

INSERT INTO sources (dish_id, source_type, title, url, publisher)
SELECT d.id, v.source_type, v.title, v.url, v.publisher
FROM (VALUES
  ('Nihari','PK','recipe','Easy Nihari (Pakistani Beef Stew)','https://www.teaforturmeric.com/easy-nihari-pakistani-beef-stew/','Tea for Turmeric'),
  ('Nihari','PK','recipe','Braised Beef Shank Stew (Nihari)','https://www.thedeliciouscrescent.com/nihari-beef-stew/','The Delicious Crescent'),

  ('Haleem','PK','recipe','Ultimate Haleem Recipe: A Hearty, Flavorful Classic','https://www.standardmedia.co.ke/evewoman/article/2001537784/ultimate-haleem-recipe-a-hearty-flavorful-classic','The Standard'),
  ('Haleem','PK','recipe','Haleem Recipe','https://www.thedeliciouscrescent.com/haleem-recipe/','The Delicious Crescent'),

  ('Fattah','EG','recipe','Egyptian Fattah Recipe – Rich, Flavorful & Authentic','https://www.munatycooking.com/egyptian-fattah/','Munaty Cooking'),
  ('Fattah','EG','recipe','Egyptian Fattah','https://amiraspantry.com/egyptian-fattah/','Amira''s Pantry')
) AS v(dish_name, iso_code, source_type, title, url, publisher)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code);
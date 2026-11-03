-- database/003_seed_dishes.sql
--
-- Seeds all 16 dishes across the 4 supported countries. Categories
-- follow the product spec's list (traditional dish / regional
-- specialty / street food / celebration food / everyday food) rather
-- than calling everything a "national dish".

INSERT INTO dishes (country_id, name, description, category, emoji, prep_time, cook_time, difficulty, servings)
VALUES
  ((SELECT id FROM countries WHERE iso_code = 'IN'), 'Biryani',
   'A layered rice dish cooked with aromatic spices and meat or vegetables, with countless regional variations.',
   'traditional dish', '🍛', '30 min', '50 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'IN'), 'Butter Chicken',
   'A North Indian dish of tandoori-style chicken simmered in a rich, buttery tomato-based sauce.',
   'regional specialty', '🍗', '20 min (plus 1 hr marinating)', '30 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'IN'), 'Dosa',
   'A thin, crisp fermented crepe made from a rice and lentil batter, popular across South India.',
   'regional specialty', '🥞', '20 min (plus overnight fermentation)', '20 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'IN'), 'Chole Bhature',
   'A North Indian combination of spiced chickpea curry served with soft, deep-fried bread.',
   'street food', '🫓', '25 min (plus overnight soaking)', '40 min', 'Medium', 4),

  ((SELECT id FROM countries WHERE iso_code = 'PK'), 'Chicken Karahi',
   'A tomato-based chicken dish cooked quickly in a wok-like pan called a karahi.',
   'everyday food', '🍗', '15 min', '30 min', 'Easy', 4),
  ((SELECT id FROM countries WHERE iso_code = 'PK'), 'Nihari',
   'A slow-cooked meat stew with a rich, spiced broth, traditionally simmered for hours.',
   'traditional dish', '🍲', '25 min', '4+ hours', 'Hard', 4),
  ((SELECT id FROM countries WHERE iso_code = 'PK'), 'Biryani',
   'A fragrant, often spicier regional style of layered rice and meat biryani.',
   'celebration food', '🍛', '30 min', '50 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'PK'), 'Haleem',
   'A slow-cooked, thick stew combining meat, lentils, and wheat, blended into a hearty porridge-like dish.',
   'celebration food', '🥘', '30 min (plus overnight soaking)', '3+ hours', 'Hard', 6),

  ((SELECT id FROM countries WHERE iso_code = 'EG'), 'Koshari',
   'A hearty combination of rice, lentils, pasta, and chickpeas, topped with tangy tomato sauce and crispy onions.',
   'street food', '🍝', '20 min', '35 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'EG'), 'Ful Medames',
   'A traditional dish of slow-cooked fava beans, seasoned with olive oil, lemon, and garlic.',
   'everyday food', '🫘', '10 min (plus overnight soaking)', '1.5 hours', 'Easy', 4),
  ((SELECT id FROM countries WHERE iso_code = 'EG'), 'Molokhia',
   'A green stew made from finely chopped molokhia (jute) leaves, usually served with rice or bread.',
   'everyday food', '🥬', '15 min', '25 min', 'Easy', 4),
  ((SELECT id FROM countries WHERE iso_code = 'EG'), 'Fattah',
   'A layered dish of crisped bread, rice, and meat, topped with a garlicky vinegar-tomato sauce, often served on special occasions.',
   'celebration food', '🍚', '30 min', '3 hours', 'Hard', 6),

  ((SELECT id FROM countries WHERE iso_code = 'RU'), 'Pelmeni',
   'Small dumplings typically filled with seasoned minced meat, boiled and served with butter or sour cream.',
   'everyday food', '🥟', '40 min', '15 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'RU'), 'Blini',
   'Thin, delicate pancakes traditionally served with sweet or savory toppings.',
   'celebration food', '🥞', '10 min (plus 20 min resting)', '20 min', 'Easy', 4),
  ((SELECT id FROM countries WHERE iso_code = 'RU'), 'Borscht',
   'A beet-based soup associated with Eastern European food traditions, prepared in many regional variations.',
   'everyday food', '🍲', '20 min', '45 min', 'Medium', 4),
  ((SELECT id FROM countries WHERE iso_code = 'RU'), 'Beef Stroganoff',
   'Sautéed strips of beef served in a creamy, tangy sauce, often with mushrooms and onions.',
   'everyday food', '🥩', '15 min', '25 min', 'Medium', 4)
ON CONFLICT DO NOTHING;


-- ---------------------------------------------------------------
-- Ingredients (deduplicated master list — many dishes below share
-- entries like Onion, Garlic, Salt, Rice, etc.)
-- ---------------------------------------------------------------
INSERT INTO ingredients (name) VALUES
  ('Basmati Rice'), ('Rice'), ('Chicken'), ('Beef'), ('Beef Shank'), ('Beef or Mutton'),
  ('Lamb or Beef'), ('Minced Meat'), ('Yogurt'), ('Onion'), ('Garlic'), ('Ginger'),
  ('Ginger-Garlic Paste'), ('Whole Spices (Biryani)'), ('Nihari Spice Blend'),
  ('Ground & Whole Spices (Haleem)'), ('Saffron'), ('Fresh Mint & Coriander'),
  ('Fresh Coriander'), ('Ground Coriander'), ('Ghee'), ('Salt'), ('Black Pepper'),
  ('Garam Masala'), ('Chili Powder'), ('Green Chili'), ('Tomato'), ('Tomato Puree'),
  ('Tomato Sauce'), ('Butter'), ('Heavy Cream'), ('Kasuri Methi'), ('Urad Dal'),
  ('Fenugreek Seeds'), ('Potato'), ('Mustard Seeds'), ('Curry Leaves'), ('Turmeric'),
  ('Oil'), ('Chickpeas'), ('Chole Masala'), ('All-Purpose Flour'), ('Baking Powder'),
  ('Coriander Seeds'), ('Cumin Seeds'), ('Cumin'), ('Whole Wheat Flour (Atta)'),
  ('Garnish (Ginger, Cilantro, Chili, Lemon)'), ('Garnish (Ghee, Cilantro, Chili, Ginger, Lemon)'),
  ('Dried Plums'), ('Biryani Masala'), ('Cracked Wheat (Daliya)'), ('Mixed Lentils'),
  ('Brown Lentils'), ('Pasta'), ('Vinegar'), ('Fava Beans'), ('Olive Oil'), ('Lemon'),
  ('Parsley'), ('Molokhia Leaves'), ('Broth'), ('Celery'), ('Carrot'), ('Bay Leaf'),
  ('Cardamom'), ('Pita Bread'), ('Egg'), ('Water'), ('Milk'), ('Sugar'), ('Beets'),
  ('Cabbage'), ('Sour Cream'), ('Mushrooms'), ('Mustard')
ON CONFLICT (name) DO NOTHING;


-- ---------------------------------------------------------------
-- dish_ingredients — one VALUES table driving the many-to-many join.
-- Columns: dish_name, iso_code, ingredient_name, quantity, unit, notes
-- ---------------------------------------------------------------
INSERT INTO dish_ingredients (dish_id, ingredient_id, quantity, unit, notes)
SELECT d.id, i.id, v.quantity, v.unit, v.notes
FROM (VALUES
  -- India: Biryani
  ('Biryani','IN','Basmati Rice','2','cup','soaked 20 min'),
  ('Biryani','IN','Chicken','500','g','or vegetables, cut into pieces'),
  ('Biryani','IN','Yogurt','1','cup','plain'),
  ('Biryani','IN','Onion','2','whole','large, thinly sliced and fried until golden'),
  ('Biryani','IN','Ginger-Garlic Paste','2','tbsp',NULL),
  ('Biryani','IN','Whole Spices (Biryani)',NULL,NULL,'2 bay leaves, 4 cloves, 2 cardamom pods, 1 cinnamon stick'),
  ('Biryani','IN','Saffron','1','pinch','soaked in 2 tbsp warm milk'),
  ('Biryani','IN','Fresh Mint & Coriander',NULL,NULL,NULL),
  ('Biryani','IN','Ghee','3','tbsp',NULL),
  ('Biryani','IN','Salt','to taste',NULL,NULL),

  -- India: Butter Chicken
  ('Butter Chicken','IN','Chicken','500','g','boneless thighs, cut into chunks'),
  ('Butter Chicken','IN','Yogurt','1/2','cup',NULL),
  ('Butter Chicken','IN','Ginger-Garlic Paste','1','tbsp',NULL),
  ('Butter Chicken','IN','Garam Masala','1','tsp',NULL),
  ('Butter Chicken','IN','Chili Powder','1','tsp',NULL),
  ('Butter Chicken','IN','Tomato Puree','2','cup',NULL),
  ('Butter Chicken','IN','Butter','3','tbsp',NULL),
  ('Butter Chicken','IN','Heavy Cream','1/4','cup',NULL),
  ('Butter Chicken','IN','Kasuri Methi','1','tsp','dried fenugreek leaves'),
  ('Butter Chicken','IN','Salt','to taste',NULL,NULL),

  -- India: Dosa
  ('Dosa','IN','Rice','2','cup',NULL),
  ('Dosa','IN','Urad Dal','1/2','cup','split black lentils'),
  ('Dosa','IN','Fenugreek Seeds','1/4','tsp',NULL),
  ('Dosa','IN','Salt','to taste',NULL,NULL),
  ('Dosa','IN','Potato','3','whole','boiled and mashed'),
  ('Dosa','IN','Mustard Seeds','1','tsp',NULL),
  ('Dosa','IN','Curry Leaves',NULL,NULL,'a few'),
  ('Dosa','IN','Onion','1','whole','sliced'),
  ('Dosa','IN','Turmeric','1/2','tsp',NULL),
  ('Dosa','IN','Oil',NULL,NULL,'for cooking'),

  -- India: Chole Bhature
  ('Chole Bhature','IN','Chickpeas','2','cup','dried, soaked overnight'),
  ('Chole Bhature','IN','Onion','2','whole','finely chopped'),
  ('Chole Bhature','IN','Tomato','2','whole','pureed'),
  ('Chole Bhature','IN','Ginger-Garlic Paste','1','tbsp',NULL),
  ('Chole Bhature','IN','Chole Masala','2','tsp',NULL),
  ('Chole Bhature','IN','All-Purpose Flour','2','cup',NULL),
  ('Chole Bhature','IN','Yogurt','1/4','cup',NULL),
  ('Chole Bhature','IN','Baking Powder','1/2','tsp',NULL),
  ('Chole Bhature','IN','Oil',NULL,NULL,'for deep-frying'),
  ('Chole Bhature','IN','Salt','to taste',NULL,NULL),

  -- Pakistan: Chicken Karahi
  ('Chicken Karahi','PK','Chicken','1','kg','bone-in pieces'),
  ('Chicken Karahi','PK','Tomato','4','whole','ripe, chopped'),
  ('Chicken Karahi','PK','Oil','1/2','cup','or ghee'),
  ('Chicken Karahi','PK','Ginger','1','tbsp','julienned'),
  ('Chicken Karahi','PK','Ginger-Garlic Paste','1','tbsp',NULL),
  ('Chicken Karahi','PK','Green Chili','4-5','whole','slit'),
  ('Chicken Karahi','PK','Coriander Seeds','1','tsp','crushed'),
  ('Chicken Karahi','PK','Cumin Seeds','1','tsp','crushed'),
  ('Chicken Karahi','PK','Fresh Coriander',NULL,NULL,NULL),
  ('Chicken Karahi','PK','Salt','to taste',NULL,NULL),
  ('Chicken Karahi','PK','Chili Powder','to taste',NULL,NULL),

  -- Pakistan: Nihari
  ('Nihari','PK','Beef Shank','1','kg','bone-in'),
  ('Nihari','PK','Onion','1','whole','thinly sliced, fried until golden'),
  ('Nihari','PK','Ginger-Garlic Paste','2','tbsp',NULL),
  ('Nihari','PK','Nihari Spice Blend',NULL,NULL,'fennel, cumin, cardamom, cloves, peppercorns, nutmeg, cinnamon'),
  ('Nihari','PK','Whole Wheat Flour (Atta)','2','tbsp','mixed with water into a slurry'),
  ('Nihari','PK','Garnish (Ginger, Cilantro, Chili, Lemon)',NULL,NULL,'julienned ginger, cilantro, green chilies, lemon wedges'),
  ('Nihari','PK','Salt','to taste',NULL,NULL),

  -- Pakistan: Biryani
  ('Biryani','PK','Basmati Rice','2','cup','soaked 20 min'),
  ('Biryani','PK','Chicken','500','g','or beef, cut into pieces'),
  ('Biryani','PK','Yogurt','1/2','cup',NULL),
  ('Biryani','PK','Potato','2','whole','halved, optional Sindhi-style'),
  ('Biryani','PK','Dried Plums',NULL,NULL,'optional'),
  ('Biryani','PK','Biryani Masala','2-3','tbsp',NULL),
  ('Biryani','PK','Onion','2','whole','fried until golden and crisp'),
  ('Biryani','PK','Fresh Mint & Coriander',NULL,NULL,NULL),

  -- Pakistan: Haleem
  ('Haleem','PK','Beef or Mutton','1','kg','bone-in cuts work well'),
  ('Haleem','PK','Cracked Wheat (Daliya)','1','cup',NULL),
  ('Haleem','PK','Mixed Lentils','1','cup','chana dal, masoor dal, moong dal, urad dal'),
  ('Haleem','PK','Onion','2','whole','thinly sliced, fried until golden'),
  ('Haleem','PK','Ginger-Garlic Paste','2','tbsp',NULL),
  ('Haleem','PK','Yogurt','1/2','cup',NULL),
  ('Haleem','PK','Ground & Whole Spices (Haleem)',NULL,NULL,'turmeric, chili powder, cumin, coriander, cinnamon, cloves, cardamom'),
  ('Haleem','PK','Garnish (Ghee, Cilantro, Chili, Ginger, Lemon)',NULL,NULL,'ghee, cilantro, green chilies, julienned ginger, lemon'),

  -- Egypt: Koshari
  ('Koshari','EG','Rice','1','cup',NULL),
  ('Koshari','EG','Brown Lentils','1','cup',NULL),
  ('Koshari','EG','Pasta','1','cup','macaroni or ditalini'),
  ('Koshari','EG','Chickpeas','1','cup','cooked'),
  ('Koshari','EG','Onion','3','whole','thinly sliced, for frying'),
  ('Koshari','EG','Tomato Sauce','2','cup',NULL),
  ('Koshari','EG','Garlic','4','clove','minced'),
  ('Koshari','EG','Vinegar','2','tbsp',NULL),
  ('Koshari','EG','Cumin','1','tsp','ground'),

  -- Egypt: Ful Medames
  ('Ful Medames','EG','Fava Beans','2','cup','dried, soaked overnight'),
  ('Ful Medames','EG','Olive Oil','1/4','cup',NULL),
  ('Ful Medames','EG','Lemon','2','whole','juiced'),
  ('Ful Medames','EG','Garlic','3','clove','crushed'),
  ('Ful Medames','EG','Cumin','1','tsp','ground'),
  ('Ful Medames','EG','Tomato',NULL,NULL,'chopped, for serving'),
  ('Ful Medames','EG','Parsley',NULL,NULL,'chopped, for serving'),
  ('Ful Medames','EG','Salt','to taste',NULL,NULL),

  -- Egypt: Molokhia
  ('Molokhia','EG','Molokhia Leaves','500','g','fresh or frozen, finely chopped'),
  ('Molokhia','EG','Broth','4','cup','chicken or vegetable'),
  ('Molokhia','EG','Garlic','4','clove','minced'),
  ('Molokhia','EG','Ground Coriander','1','tbsp',NULL),
  ('Molokhia','EG','Ghee','2','tbsp','or oil'),
  ('Molokhia','EG','Salt','to taste',NULL,NULL),
  ('Molokhia','EG','Black Pepper','to taste',NULL,NULL),

  -- Egypt: Fattah
  ('Fattah','EG','Lamb or Beef','1','kg','cut into chunks'),
  ('Fattah','EG','Onion','1','whole','quartered, for the broth'),
  ('Fattah','EG','Tomato','1','whole','for the broth'),
  ('Fattah','EG','Celery',NULL,NULL,'a few pieces, for the broth'),
  ('Fattah','EG','Bay Leaf','2','whole',NULL),
  ('Fattah','EG','Cardamom','1','pinch','ground'),
  ('Fattah','EG','Black Pepper','to taste',NULL,NULL),
  ('Fattah','EG','Rice','2','cup',NULL),
  ('Fattah','EG','Pita Bread','2-3','loaf','cut into squares'),
  ('Fattah','EG','Garlic','6','clove','minced, for the sauce'),
  ('Fattah','EG','Vinegar','1/2','cup','white'),
  ('Fattah','EG','Tomato Sauce','2','cup',NULL),
  ('Fattah','EG','Ghee',NULL,NULL,'or oil'),
  ('Fattah','EG','Salt','to taste',NULL,NULL),

  -- Russia: Pelmeni
  ('Pelmeni','RU','All-Purpose Flour','2','cup','plus more for dusting'),
  ('Pelmeni','RU','Egg','1','whole',NULL),
  ('Pelmeni','RU','Water','1/2','cup',NULL),
  ('Pelmeni','RU','Minced Meat','300','g','beef and pork blend'),
  ('Pelmeni','RU','Onion','1','whole','small, finely grated'),
  ('Pelmeni','RU','Salt','to taste',NULL,NULL),
  ('Pelmeni','RU','Black Pepper','to taste',NULL,NULL),
  ('Pelmeni','RU','Butter',NULL,NULL,'or sour cream, for serving'),

  -- Russia: Blini
  ('Blini','RU','All-Purpose Flour','1','cup',NULL),
  ('Blini','RU','Milk','1.5','cup',NULL),
  ('Blini','RU','Egg','2','whole',NULL),
  ('Blini','RU','Sugar','1','tbsp',NULL),
  ('Blini','RU','Butter','2','tbsp','melted, plus more for the pan'),
  ('Blini','RU','Salt','1','pinch',NULL),

  -- Russia: Borscht
  ('Borscht','RU','Beets','3','whole','medium, grated'),
  ('Borscht','RU','Carrot','2','whole','grated'),
  ('Borscht','RU','Onion','1','whole','diced'),
  ('Borscht','RU','Potato','2','whole','cubed'),
  ('Borscht','RU','Cabbage','2','cup','shredded'),
  ('Borscht','RU','Broth','6','cup','vegetable or beef'),
  ('Borscht','RU','Vinegar','2','tbsp','or lemon juice'),
  ('Borscht','RU','Sour Cream',NULL,NULL,'for serving'),

  -- Russia: Beef Stroganoff
  ('Beef Stroganoff','RU','Beef','500','g','sirloin, thinly sliced into strips'),
  ('Beef Stroganoff','RU','Onion','1','whole','sliced'),
  ('Beef Stroganoff','RU','Mushrooms','250','g','sliced'),
  ('Beef Stroganoff','RU','Sour Cream','1','cup',NULL),
  ('Beef Stroganoff','RU','Broth','1','cup','beef'),
  ('Beef Stroganoff','RU','Mustard','1','tbsp','optional'),
  ('Beef Stroganoff','RU','Butter','2','tbsp',NULL),
  ('Beef Stroganoff','RU','Salt','to taste',NULL,NULL),
  ('Beef Stroganoff','RU','Black Pepper','to taste',NULL,NULL)
) AS v(dish_name, iso_code, ingredient_name, quantity, unit, notes)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code)
JOIN ingredients i ON i.name = v.ingredient_name
ON CONFLICT (dish_id, ingredient_id) DO NOTHING;


-- ---------------------------------------------------------------
-- recipe_steps — same VALUES-table pattern.
-- Columns: dish_name, iso_code, step_number, instruction
-- ---------------------------------------------------------------
INSERT INTO recipe_steps (dish_id, step_number, instruction)
SELECT d.id, v.step_number, v.instruction
FROM (VALUES
  ('Biryani','IN',1,'Marinate the chicken with yogurt, ginger-garlic paste, and half the fried onions for at least 30 minutes.'),
  ('Biryani','IN',2,'Parboil the rice with the whole spices and salt until about 70% cooked, then drain.'),
  ('Biryani','IN',3,'In a heavy pot, cook the marinated chicken in ghee until mostly done.'),
  ('Biryani','IN',4,'Layer the parboiled rice over the chicken, then top with the remaining fried onions, saffron milk, mint, and coriander.'),
  ('Biryani','IN',5,'Cover tightly and cook on very low heat for 20-25 minutes.'),
  ('Biryani','IN',6,'Let it rest for 5 minutes off the heat, then gently fluff the layers together before serving.'),

  ('Butter Chicken','IN',1,'Marinate the chicken in yogurt, ginger-garlic paste, and half the spices for at least 1 hour.'),
  ('Butter Chicken','IN',2,'Roast, grill, or pan-sear the chicken until lightly charred at the edges; set aside.'),
  ('Butter Chicken','IN',3,'Melt the butter and cook the tomato puree with the remaining spices until it thickens and darkens slightly.'),
  ('Butter Chicken','IN',4,'Stir in the cream and simmer for a few minutes.'),
  ('Butter Chicken','IN',5,'Add the cooked chicken and simmer until heated through and coated in the sauce.'),
  ('Butter Chicken','IN',6,'Finish with a pinch of crushed kasuri methi and a small extra knob of butter before serving.'),

  ('Dosa','IN',1,'Soak the rice, urad dal, and fenugreek seeds separately for 4-6 hours, then grind into a smooth batter and combine.'),
  ('Dosa','IN',2,'Let the batter ferment overnight at room temperature until slightly risen and bubbly; add salt.'),
  ('Dosa','IN',3,'For the filling, temper mustard seeds and curry leaves in oil, add onions and turmeric, then stir in the mashed potato.'),
  ('Dosa','IN',4,'Heat a flat griddle, pour a ladle of batter, and spread it thin in a circular motion.'),
  ('Dosa','IN',5,'Drizzle a little oil around the edges and cook until the base turns golden and crisp.'),
  ('Dosa','IN',6,'Add a portion of the potato filling, fold the dosa, and serve hot with chutney and sambar.'),

  ('Chole Bhature','IN',1,'Boil the soaked chickpeas until tender, about 25-30 minutes in a pressure cooker or longer on the stovetop.'),
  ('Chole Bhature','IN',2,'Sauté onions until golden, add ginger-garlic paste, tomato puree, and chole masala, and cook until the oil separates.'),
  ('Chole Bhature','IN',3,'Add the boiled chickpeas with a little of their cooking liquid and simmer for 10-15 minutes.'),
  ('Chole Bhature','IN',4,'For the bhature, knead flour, yogurt, baking powder, and a little oil into a soft dough; let it rest for at least 2 hours.'),
  ('Chole Bhature','IN',5,'Roll the dough into rounds and deep-fry in hot oil until puffed and golden on both sides.'),
  ('Chole Bhature','IN',6,'Serve the hot chickpea curry alongside the fried bread.'),

  ('Chicken Karahi','PK',1,'Heat the oil in a karahi or wide, heavy pan and sear the chicken pieces until lightly browned.'),
  ('Chicken Karahi','PK',2,'Add the ginger-garlic paste and cook for a minute until fragrant.'),
  ('Chicken Karahi','PK',3,'Add the chopped tomatoes, salt, and spices, and cook uncovered over medium-high heat, stirring occasionally.'),
  ('Chicken Karahi','PK',4,'Continue cooking until the tomatoes break down completely and the oil begins to separate at the edges.'),
  ('Chicken Karahi','PK',5,'Add the green chilies and julienned ginger, and simmer until the chicken is fully cooked and tender.'),
  ('Chicken Karahi','PK',6,'Garnish with fresh coriander and serve hot with naan.'),

  ('Nihari','PK',1,'Sear the beef shank in oil with the fried onions and ginger-garlic paste until lightly browned.'),
  ('Nihari','PK',2,'Stir in the nihari spice blend and salt, then add enough water to fully cover the meat.'),
  ('Nihari','PK',3,'Bring to a boil, then reduce to a very low simmer, cover, and cook for 3-4 hours until the meat is fall-apart tender.'),
  ('Nihari','PK',4,'Remove the meat and set it aside briefly; whisk the flour slurry into the simmering broth to thicken it.'),
  ('Nihari','PK',5,'Return the meat to the pot and simmer for another 20-30 minutes until the gravy is rich and glossy.'),
  ('Nihari','PK',6,'Serve hot, topped with julienned ginger, cilantro, and green chilies, with a squeeze of lemon and naan on the side.'),

  ('Biryani','PK',1,'Marinate the meat in yogurt and biryani masala for at least 30 minutes.'),
  ('Biryani','PK',2,'Cook the meat with the fried onions and chopped tomatoes until tender and the gravy thickens slightly.'),
  ('Biryani','PK',3,'Parboil the rice with whole spices until about 70% cooked, then drain.'),
  ('Biryani','PK',4,'Layer the rice over the meat mixture, adding potatoes and dried plums if using.'),
  ('Biryani','PK',5,'Top with more fried onions, mint, and coriander, then cover tightly and cook on low heat for 20-25 minutes.'),
  ('Biryani','PK',6,'Rest for 5 minutes, then gently mix the layers together before serving.'),

  ('Haleem','PK',1,'Soak the wheat and lentils together overnight, then boil in plenty of water until very soft, about 1.5-2 hours.'),
  ('Haleem','PK',2,'Blend the cooked wheat and lentils into a thick, semi-smooth mixture using an immersion blender.'),
  ('Haleem','PK',3,'Separately, cook the meat with half the fried onions, ginger-garlic paste, yogurt, and spices until tender enough to shred.'),
  ('Haleem','PK',4,'Shred the meat finely, discarding any bones, and combine it with its cooking liquid.'),
  ('Haleem','PK',5,'Stir the meat and its liquid into the blended wheat and lentils, and simmer on low heat for 1-2 hours, stirring often.'),
  ('Haleem','PK',6,'Serve hot, topped with the remaining fried onions, cilantro, ginger, green chilies, ghee, and lemon wedges.'),

  ('Koshari','EG',1,'Cook the rice, lentils, and pasta separately according to their own cooking times, until tender.'),
  ('Koshari','EG',2,'Fry the sliced onions in oil over medium heat until deep golden and crisp; set aside.'),
  ('Koshari','EG',3,'For the sauce, sauté minced garlic in a little oil, add the tomato sauce, vinegar, and cumin, and simmer for 10-15 minutes.'),
  ('Koshari','EG',4,'In a serving bowl, layer the rice, lentils, and pasta, then top with the chickpeas.'),
  ('Koshari','EG',5,'Spoon the tomato sauce generously over the top.'),
  ('Koshari','EG',6,'Finish with a generous pile of crispy fried onions before serving.'),

  ('Ful Medames','EG',1,'Drain the soaked beans and simmer them in fresh water over low heat until very tender, about 1-1.5 hours.'),
  ('Ful Medames','EG',2,'Drain most of the cooking liquid, leaving a little to keep the beans moist.'),
  ('Ful Medames','EG',3,'Lightly mash the beans with a fork, leaving some texture.'),
  ('Ful Medames','EG',4,'Stir in the olive oil, lemon juice, crushed garlic, cumin, and salt.'),
  ('Ful Medames','EG',5,'Spoon into bowls and top with chopped tomato and parsley.'),
  ('Ful Medames','EG',6,'Serve warm with bread.'),

  ('Molokhia','EG',1,'Bring the broth to a simmer in a pot.'),
  ('Molokhia','EG',2,'Add the chopped molokhia leaves and simmer gently for 15-20 minutes, stirring occasionally.'),
  ('Molokhia','EG',3,'In a small pan, sauté the minced garlic and ground coriander in ghee until fragrant, being careful not to burn the garlic.'),
  ('Molokhia','EG',4,'Stir this garlic-coriander mixture into the simmering molokhia.'),
  ('Molokhia','EG',5,'Season with salt and pepper, and simmer for a few more minutes until thickened slightly.'),
  ('Molokhia','EG',6,'Serve hot over rice or with bread.'),

  ('Fattah','EG',1,'Brown the meat in ghee, then add the onion, tomato, celery, bay leaves, cardamom, and pepper, and cover with boiling water.'),
  ('Fattah','EG',2,'Simmer for 2-3 hours until the meat is completely tender; strain and reserve the broth.'),
  ('Fattah','EG',3,'Cook the rice in a little ghee and some of the reserved broth until fluffy.'),
  ('Fattah','EG',4,'Toast or fry the pita squares in ghee until golden and crisp.'),
  ('Fattah','EG',5,'For the sauce, sauté the minced garlic in ghee, then add the vinegar, tomato sauce, and a cup of the reserved broth, and simmer until slightly thickened.'),
  ('Fattah','EG',6,'To assemble, layer the crispy bread, then the rice, then the meat, and pour the hot garlicky sauce generously over the top just before serving.'),

  ('Pelmeni','RU',1,'Mix the flour, egg, water, and a pinch of salt into a firm dough; knead until smooth, then let it rest for 20 minutes.'),
  ('Pelmeni','RU',2,'Combine the minced meat with the grated onion, salt, and pepper.'),
  ('Pelmeni','RU',3,'Roll the dough out thinly and cut into small circles.'),
  ('Pelmeni','RU',4,'Place a small spoonful of filling in the center of each circle, fold in half, and pinch the edges together, then bring the two corners together to seal.'),
  ('Pelmeni','RU',5,'Bring a large pot of salted water to a boil and drop in the dumplings.'),
  ('Pelmeni','RU',6,'Boil until the pelmeni float to the surface, about 5-7 minutes, then serve with butter or sour cream.'),

  ('Blini','RU',1,'Whisk together the flour, milk, eggs, sugar, and salt into a thin, smooth batter.'),
  ('Blini','RU',2,'Stir in the melted butter and let the batter rest for about 20 minutes.'),
  ('Blini','RU',3,'Heat a lightly buttered non-stick pan over medium heat.'),
  ('Blini','RU',4,'Pour in a thin layer of batter, swirling the pan to coat it evenly.'),
  ('Blini','RU',5,'Cook until bubbles form and the edges lift, then flip and cook briefly on the other side.'),
  ('Blini','RU',6,'Serve warm with your choice of toppings, such as sour cream, jam, or smoked fish.'),

  ('Borscht','RU',1,'Sauté the grated beets, carrots, and onion in a little oil until softened.'),
  ('Borscht','RU',2,'Add the broth, potatoes, and cabbage, and bring to a simmer.'),
  ('Borscht','RU',3,'Cook until the vegetables are tender, about 25-30 minutes.'),
  ('Borscht','RU',4,'Stir in the vinegar or lemon juice to brighten the flavor, and adjust salt to taste.'),
  ('Borscht','RU',5,'Simmer for a few more minutes to let the flavors combine.'),
  ('Borscht','RU',6,'Serve hot with a generous dollop of sour cream.'),

  ('Beef Stroganoff','RU',1,'Season the beef strips and sear them quickly in butter over high heat; set aside.'),
  ('Beef Stroganoff','RU',2,'In the same pan, sauté the onions until softened, then add the mushrooms and cook until golden.'),
  ('Beef Stroganoff','RU',3,'Pour in the broth and simmer for a few minutes to reduce slightly.'),
  ('Beef Stroganoff','RU',4,'Stir in the sour cream and mustard, and simmer gently (avoid boiling, so the sour cream doesn''t separate).'),
  ('Beef Stroganoff','RU',5,'Return the beef to the pan and warm through.'),
  ('Beef Stroganoff','RU',6,'Serve over egg noodles, rice, or mashed potatoes.')
) AS v(dish_name, iso_code, step_number, instruction)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code)
ON CONFLICT (dish_id, step_number) DO NOTHING;


INSERT INTO dishes (country_id, name, description, history, category, emoji, prep_time, cook_time, difficulty, servings)
VALUES
  (
    (SELECT id FROM countries WHERE iso_code = 'JP'), 'Shoyu Ramen',
    'A noodle soup built on a soy-sauce-seasoned broth, topped with sliced pork, a marinated egg, and other classic garnishes.',
    'Ramen is believed to have developed from Chinese wheat-noodle dishes introduced to Japan, later adapted with distinctly Japanese broths, seasonings, and toppings over the 20th century.',
    'street food', '🍜', '20 min', '45 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'JP'), 'Nigiri Sushi',
    'Hand-shaped ovals of vinegared rice topped with a thin slice of raw fish, typically dabbed with a little wasabi.',
    'Sushi is believed to have originated in China as a method of preserving fish in fermented rice; nigiri-style sushi as commonly eaten today is often credited to Hanaya Yohei in 19th-century Edo (Tokyo).',
    'traditional dish', '🍣', '1 hr', '30 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'CN'), 'Jiaozi (Pork Dumplings)',
    'Crescent-shaped dumplings filled with seasoned minced pork and vegetables, boiled, steamed, or pan-fried.',
    'According to a popular legend, jiaozi were first created by the physician Zhang Zhongjing during the Eastern Han dynasty; today they are strongly associated with Lunar New Year and the Winter Solstice.',
    'celebration food', '🥟', '45 min', '15 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'CN'), 'Kung Pao Chicken',
    'A Sichuan stir-fry of diced chicken, roasted peanuts, and dried chilies in a savory-sweet-tangy sauce.',
    'The dish is commonly said to be named after Ding Baozhen, a Qing dynasty official whose title was "Gong Bao" (Kung Pao), though accounts of its exact origin vary.',
    'regional specialty', '🥜', '20 min', '10 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'MA'), 'Chicken Tagine with Preserved Lemon & Olives',
    'Chicken slow-cooked with onions, saffron, and warm spices, finished with tangy preserved lemon and olives.',
    'Tagines take their name from the traditional conical clay pot they are slow-cooked in, a cooking method long used across Morocco and the wider Maghreb region.',
    'traditional dish', '🍲', '20 min', '50 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'MA'), 'Seven-Vegetable Couscous',
    'Steamed semolina couscous served with meat and a medley of vegetables in a fragrant, spiced broth.',
    'Couscous is believed to have Amazigh (Berber) origins and is a staple across North Africa; UNESCO recognized it in 2020 as an Intangible Cultural Heritage shared by Morocco, Algeria, Tunisia, and Mauritania.',
    'celebration food', '🍛', '25 min', '1.5 hours', 'Medium', 6
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'NG'), 'Jollof Rice',
    'A one-pot rice dish simmered in a smoky tomato and pepper base until deep orange and richly flavored.',
    'Jollof rice is generally traced to the Wolof people of the Senegambia region, later spreading and adapting across West Africa; several countries today have their own distinct styles.',
    'celebration food', '🍚', '15 min', '45 min', 'Medium', 6
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'NG'), 'Egusi Soup',
    'A hearty soup thickened with ground melon seeds, cooked with palm oil, leafy greens, and meat or fish.',
    'Egusi soup is prepared across many Nigerian ethnic groups, each with their own regional variations, and is also eaten elsewhere in West Africa.',
    'everyday food', '🥘', '25 min', '45 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'MX'), 'Tacos al Pastor',
    'Thin slices of achiote-marinated pork, traditionally spit-roasted, served on small corn tortillas with pineapple.',
    'Tacos al pastor developed in central Mexico in the mid-20th century, adapting spit-roasting techniques brought by Lebanese immigrants to local ingredients like pork and pineapple.',
    'street food', '🌮', '20 min (plus 2 hr marinating)', '20 min', 'Medium', 4
  ),
  (
    (SELECT id FROM countries WHERE iso_code = 'MX'), 'Mole Poblano',
    'A complex, deep sauce of dried chilies, nuts, spices, and chocolate, traditionally served over chicken or turkey.',
    'According to a popular legend, mole poblano was created by nuns at a convent in Puebla who improvised a sauce for a visiting archbishop from the ingredients on hand; the story is widely repeated but not verified.',
    'celebration food', '🍫', '30 min', '2 hours', 'Hard', 8
  )
ON CONFLICT DO NOTHING;


INSERT INTO ingredients (name) VALUES
  ('Ramen Noodles'), ('Kombu (Dried Kelp)'), ('Bonito Flakes'), ('Japanese Leek'),
  ('Soy Sauce'), ('Mirin'), ('Chashu Pork'), ('Soft-Boiled Egg (Ajitsuke Tamago)'),
  ('Nori'), ('Green Onion'), ('Menma (Fermented Bamboo Shoots)'), ('Sushi Rice'),
  ('Rice Vinegar'), ('Sushi-Grade Fish'), ('Wasabi'), ('Pickled Ginger'),
  ('Dumpling Wrappers'), ('Ground Pork'), ('Napa Cabbage'), ('Sesame Oil'),
  ('Rice Wine'), ('Chili Oil'), ('Roasted Peanuts'), ('Dried Chili Peppers'),
  ('Sichuan Peppercorns'), ('Chinese Black Vinegar'), ('Cornstarch'),
  ('Preserved Lemon'), ('Green Olives'), ('Paprika'), ('Couscous (Semolina)'),
  ('Turnip'), ('Zucchini'), ('Pumpkin or Squash'), ('Ras El Hanout'),
  ('Red Bell Pepper'), ('Scotch Bonnet Pepper'), ('Curry Powder'), ('Thyme'),
  ('Ground Egusi (Melon Seeds)'), ('Palm Oil'), ('Ground Crayfish'),
  ('Locust Beans (Iru)'), ('Leafy Greens (Pumpkin Leaves or Spinach)'),
  ('Achiote Paste'), ('Guajillo Chiles'), ('Oregano'), ('Pineapple Juice'),
  ('Corn Tortillas'), ('Pineapple'), ('White Onion'), ('Cilantro'), ('Lime'),
  ('Ancho Chiles'), ('Mulato Chiles'), ('Pasilla Chiles'), ('Almonds'),
  ('Raisins'), ('Sesame Seeds'), ('Stale Tortilla or Bread'), ('Cinnamon'),
  ('Cloves'), ('Anise'), ('Mexican Chocolate'), ('Lard')
ON CONFLICT (name) DO NOTHING;


-- ---------------------------------------------------------------
-- dish_ingredients
-- ---------------------------------------------------------------
INSERT INTO dish_ingredients (dish_id, ingredient_id, quantity, unit, notes)
SELECT d.id, i.id, v.quantity, v.unit, v.notes
FROM (VALUES
  -- Japan: Shoyu Ramen
  ('Shoyu Ramen','JP','Ramen Noodles','4','portion','fresh, or dried'),
  ('Shoyu Ramen','JP','Chicken','3-4','piece','wings or carcass, for broth'),
  ('Shoyu Ramen','JP','Kombu (Dried Kelp)','10','g',NULL),
  ('Shoyu Ramen','JP','Bonito Flakes','15','g',NULL),
  ('Shoyu Ramen','JP','Ginger','20','g','sliced'),
  ('Shoyu Ramen','JP','Garlic','2','clove',NULL),
  ('Shoyu Ramen','JP','Japanese Leek','50','g',NULL),
  ('Shoyu Ramen','JP','Soy Sauce',NULL,NULL,'for the tare (seasoning base)'),
  ('Shoyu Ramen','JP','Mirin',NULL,NULL,NULL),
  ('Shoyu Ramen','JP','Chashu Pork',NULL,NULL,'braised, sliced'),
  ('Shoyu Ramen','JP','Soft-Boiled Egg (Ajitsuke Tamago)','1','whole','per bowl'),
  ('Shoyu Ramen','JP','Nori',NULL,NULL,NULL),
  ('Shoyu Ramen','JP','Green Onion',NULL,NULL,'sliced'),
  ('Shoyu Ramen','JP','Menma (Fermented Bamboo Shoots)',NULL,NULL,NULL),

  -- Japan: Nigiri Sushi
  ('Nigiri Sushi','JP','Sushi Rice','2','cup',NULL),
  ('Nigiri Sushi','JP','Rice Vinegar',NULL,NULL,'with sugar and salt, for seasoning the rice'),
  ('Nigiri Sushi','JP','Kombu (Dried Kelp)','1','piece','small, for cooking the rice'),
  ('Nigiri Sushi','JP','Sushi-Grade Fish','400','g','salmon or tuna, thinly sliced'),
  ('Nigiri Sushi','JP','Wasabi',NULL,NULL,NULL),
  ('Nigiri Sushi','JP','Soy Sauce',NULL,NULL,'for serving'),
  ('Nigiri Sushi','JP','Pickled Ginger',NULL,NULL,'for serving'),

  -- China: Jiaozi
  ('Jiaozi (Pork Dumplings)','CN','Dumpling Wrappers','50','whole','or homemade dough'),
  ('Jiaozi (Pork Dumplings)','CN','Ground Pork','400','g',NULL),
  ('Jiaozi (Pork Dumplings)','CN','Napa Cabbage',NULL,NULL,'finely chopped, salted and squeezed dry'),
  ('Jiaozi (Pork Dumplings)','CN','Green Onion',NULL,NULL,'finely chopped'),
  ('Jiaozi (Pork Dumplings)','CN','Ginger','1','tbsp','grated'),
  ('Jiaozi (Pork Dumplings)','CN','Garlic','2','clove','minced'),
  ('Jiaozi (Pork Dumplings)','CN','Soy Sauce','1','tbsp',NULL),
  ('Jiaozi (Pork Dumplings)','CN','Sesame Oil','1','tsp',NULL),
  ('Jiaozi (Pork Dumplings)','CN','Rice Wine','1','tsp','optional'),
  ('Jiaozi (Pork Dumplings)','CN','Chinese Black Vinegar',NULL,NULL,'for dipping sauce'),
  ('Jiaozi (Pork Dumplings)','CN','Chili Oil',NULL,NULL,'for dipping sauce, optional'),

  -- China: Kung Pao Chicken
  ('Kung Pao Chicken','CN','Chicken','300','g','breast, diced'),
  ('Kung Pao Chicken','CN','Roasted Peanuts','80','g',NULL),
  ('Kung Pao Chicken','CN','Dried Chili Peppers','10','whole',NULL),
  ('Kung Pao Chicken','CN','Sichuan Peppercorns','1','tsp',NULL),
  ('Kung Pao Chicken','CN','Garlic','2','clove','sliced'),
  ('Kung Pao Chicken','CN','Ginger',NULL,NULL,'sliced'),
  ('Kung Pao Chicken','CN','Green Onion',NULL,NULL,'white part, cut into strips'),
  ('Kung Pao Chicken','CN','Soy Sauce','1','tbsp',NULL),
  ('Kung Pao Chicken','CN','Chinese Black Vinegar','1','tbsp',NULL),
  ('Kung Pao Chicken','CN','Sugar','1','tsp',NULL),
  ('Kung Pao Chicken','CN','Rice Wine','1','tsp',NULL),
  ('Kung Pao Chicken','CN','Cornstarch','1','tsp',NULL),
  ('Kung Pao Chicken','CN','Sesame Oil','1','tsp',NULL),

  -- Morocco: Chicken Tagine
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Chicken','1','whole','cut into pieces'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Onion','2','whole','sliced'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Garlic','3','clove',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Ginger','1','tsp','ground'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Turmeric','1','tsp',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Paprika','1','tsp',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Saffron',NULL,NULL,'a few threads'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Preserved Lemon','2','whole',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Green Olives','1','cup',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Cilantro',NULL,NULL,'chopped'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Parsley',NULL,NULL,'chopped'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Olive Oil','3','tbsp',NULL),
  ('Chicken Tagine with Preserved Lemon & Olives','MA','Salt','to taste',NULL,NULL),

  -- Morocco: Seven-Vegetable Couscous
  ('Seven-Vegetable Couscous','MA','Couscous (Semolina)','500','g',NULL),
  ('Seven-Vegetable Couscous','MA','Lamb or Beef','1','kg','or chicken, cut into pieces'),
  ('Seven-Vegetable Couscous','MA','Chickpeas','1','cup','cooked'),
  ('Seven-Vegetable Couscous','MA','Carrot','2','whole',NULL),
  ('Seven-Vegetable Couscous','MA','Turnip','2','whole',NULL),
  ('Seven-Vegetable Couscous','MA','Zucchini','2','whole',NULL),
  ('Seven-Vegetable Couscous','MA','Pumpkin or Squash','400','g',NULL),
  ('Seven-Vegetable Couscous','MA','Tomato','2','whole',NULL),
  ('Seven-Vegetable Couscous','MA','Onion','1','whole',NULL),
  ('Seven-Vegetable Couscous','MA','Ras El Hanout','1','tsp',NULL),
  ('Seven-Vegetable Couscous','MA','Ginger','1/2','tsp','ground'),
  ('Seven-Vegetable Couscous','MA','Turmeric','1/2','tsp',NULL),
  ('Seven-Vegetable Couscous','MA','Saffron',NULL,NULL,'a few threads'),
  ('Seven-Vegetable Couscous','MA','Olive Oil',NULL,NULL,NULL),

  -- Nigeria: Jollof Rice
  ('Jollof Rice','NG','Rice','4','cup','long-grain, parboiled'),
  ('Jollof Rice','NG','Tomato','6','whole',NULL),
  ('Jollof Rice','NG','Red Bell Pepper','2','whole',NULL),
  ('Jollof Rice','NG','Scotch Bonnet Pepper','1-2','whole','to taste'),
  ('Jollof Rice','NG','Onion','2','whole',NULL),
  ('Jollof Rice','NG','Tomato Sauce','2','tbsp','tomato paste'),
  ('Jollof Rice','NG','Curry Powder','2','tsp',NULL),
  ('Jollof Rice','NG','Thyme','1/2','tsp','dried'),
  ('Jollof Rice','NG','Bay Leaf','2','whole',NULL),
  ('Jollof Rice','NG','Broth','2','cup','chicken or vegetable'),
  ('Jollof Rice','NG','Oil','3','tbsp',NULL),
  ('Jollof Rice','NG','Salt','to taste',NULL,NULL),

  -- Nigeria: Egusi Soup
  ('Egusi Soup','NG','Ground Egusi (Melon Seeds)','4','cup',NULL),
  ('Egusi Soup','NG','Palm Oil','1/2','cup',NULL),
  ('Egusi Soup','NG','Onion','1','cup','blended'),
  ('Egusi Soup','NG','Chicken','500','g','or assorted meat and fish'),
  ('Egusi Soup','NG','Ground Crayfish',NULL,NULL,'to taste'),
  ('Egusi Soup','NG','Locust Beans (Iru)','2','tsp','optional'),
  ('Egusi Soup','NG','Leafy Greens (Pumpkin Leaves or Spinach)','2','cup','chopped'),
  ('Egusi Soup','NG','Broth','6','cup',NULL),
  ('Egusi Soup','NG','Salt','to taste',NULL,NULL),

  -- Mexico: Tacos al Pastor
  ('Tacos al Pastor','MX','Chicken','900','g','substitute for pork shoulder if preferred, thinly sliced'),
  ('Tacos al Pastor','MX','Achiote Paste','2','tbsp',NULL),
  ('Tacos al Pastor','MX','Garlic','4','clove','minced'),
  ('Tacos al Pastor','MX','Cumin','2','tsp',NULL),
  ('Tacos al Pastor','MX','Oregano','2','tsp','dried'),
  ('Tacos al Pastor','MX','Pineapple Juice','1/2','cup',NULL),
  ('Tacos al Pastor','MX','Vinegar','2','tbsp','white'),
  ('Tacos al Pastor','MX','Corn Tortillas','12','whole',NULL),
  ('Tacos al Pastor','MX','Pineapple',NULL,NULL,'sliced, for grilling'),
  ('Tacos al Pastor','MX','White Onion',NULL,NULL,'diced'),
  ('Tacos al Pastor','MX','Cilantro',NULL,NULL,'chopped'),
  ('Tacos al Pastor','MX','Lime',NULL,NULL,'wedges'),

  -- Mexico: Mole Poblano
  ('Mole Poblano','MX','Ancho Chiles','3','whole',NULL),
  ('Mole Poblano','MX','Mulato Chiles','3','whole',NULL),
  ('Mole Poblano','MX','Pasilla Chiles','3','whole',NULL),
  ('Mole Poblano','MX','Tomato','6','whole',NULL),
  ('Mole Poblano','MX','Onion','1','whole',NULL),
  ('Mole Poblano','MX','Garlic','2','clove',NULL),
  ('Mole Poblano','MX','Almonds','60','g',NULL),
  ('Mole Poblano','MX','Raisins','50','g',NULL),
  ('Mole Poblano','MX','Sesame Seeds','40','g','plus extra for garnish'),
  ('Mole Poblano','MX','Stale Tortilla or Bread','1','piece',NULL),
  ('Mole Poblano','MX','Cinnamon','1','stick',NULL),
  ('Mole Poblano','MX','Cloves','3','whole',NULL),
  ('Mole Poblano','MX','Anise','1/2','tsp',NULL),
  ('Mole Poblano','MX','Mexican Chocolate','60','g',NULL),
  ('Mole Poblano','MX','Chicken','1','whole','cooked, or turkey'),
  ('Mole Poblano','MX','Lard',NULL,NULL,'or vegetable oil'),
  ('Mole Poblano','MX','Salt','to taste',NULL,NULL)
) AS v(dish_name, iso_code, ingredient_name, quantity, unit, notes)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code)
JOIN ingredients i ON i.name = v.ingredient_name
ON CONFLICT (dish_id, ingredient_id) DO NOTHING;


INSERT INTO recipe_steps (dish_id, step_number, instruction)
SELECT d.id, v.step_number, v.instruction
FROM (VALUES
  ('Shoyu Ramen','JP',1,'Soak the kombu in water for 30 minutes, then heat gently with chicken, bonito flakes, ginger, garlic, and leek; simmer for 30-45 minutes and strain for a clear broth.'),
  ('Shoyu Ramen','JP',2,'Make the tare (seasoning base) by combining soy sauce with a little rendered fat and mirin.'),
  ('Shoyu Ramen','JP',3,'Cook the ramen noodles separately in boiling water until just tender, then drain well.'),
  ('Shoyu Ramen','JP',4,'Spoon a portion of tare into each bowl, then ladle in the hot broth and stir to combine.'),
  ('Shoyu Ramen','JP',5,'Add the noodles, then top with sliced chashu, a soft-boiled egg, menma, nori, and green onions.'),
  ('Shoyu Ramen','JP',6,'Serve immediately while hot.'),

  ('Nigiri Sushi','JP',1,'Rinse the rice until the water runs clear, then cook it with a small piece of kombu.'),
  ('Nigiri Sushi','JP',2,'While the rice is still warm, fold in a seasoned mixture of rice vinegar, sugar, and salt, then let it cool to room temperature.'),
  ('Nigiri Sushi','JP',3,'Slice the fish thinly on a diagonal using a sharp knife.'),
  ('Nigiri Sushi','JP',4,'Wet your hands, take a small amount of rice, and shape it into a compact oval.'),
  ('Nigiri Sushi','JP',5,'Dab a little wasabi onto the rice, then press a slice of fish on top and mold it gently to the rice.'),
  ('Nigiri Sushi','JP',6,'Serve immediately with soy sauce and pickled ginger.'),

  ('Jiaozi (Pork Dumplings)','CN',1,'Mix the ground pork with the chopped cabbage, green onion, ginger, garlic, soy sauce, sesame oil, and rice wine.'),
  ('Jiaozi (Pork Dumplings)','CN',2,'Place a spoonful of filling in the center of each wrapper.'),
  ('Jiaozi (Pork Dumplings)','CN',3,'Moisten the edges of the wrapper with water, then fold and pleat to seal.'),
  ('Jiaozi (Pork Dumplings)','CN',4,'Bring a large pot of water to a boil and add the dumplings.'),
  ('Jiaozi (Pork Dumplings)','CN',5,'Once the water returns to a boil, add a splash of cold water; repeat once or twice until the dumplings float and are cooked through.'),
  ('Jiaozi (Pork Dumplings)','CN',6,'Serve with a dipping sauce of soy sauce, vinegar, and chili oil.'),

  ('Kung Pao Chicken','CN',1,'Marinate the diced chicken briefly with a little salt, rice wine, and cornstarch.'),
  ('Kung Pao Chicken','CN',2,'Mix the soy sauce, vinegar, sugar, and a little water into a sauce and set aside.'),
  ('Kung Pao Chicken','CN',3,'Stir-fry the garlic, ginger, and Sichuan peppercorns in hot oil until fragrant.'),
  ('Kung Pao Chicken','CN',4,'Add the chicken and dried chilies, and stir-fry over high heat until the chicken is cooked through.'),
  ('Kung Pao Chicken','CN',5,'Add the peanuts and green onion, then pour in the sauce and toss until everything is glossy and coated.'),
  ('Kung Pao Chicken','CN',6,'Serve hot with steamed rice.'),

  ('Chicken Tagine with Preserved Lemon & Olives','MA',1,'Sauté the onions in olive oil until soft, then add the garlic, saffron, and ground spices.'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA',2,'Add the chicken pieces, season with salt, and add enough water to partially cover.'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA',3,'Cover and simmer gently, turning occasionally, until the chicken is tender.'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA',4,'Add the preserved lemon and olives, and continue simmering until the sauce thickens slightly.'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA',5,'Stir in the chopped cilantro and parsley just before serving.'),
  ('Chicken Tagine with Preserved Lemon & Olives','MA',6,'Serve hot with bread or couscous.'),

  ('Seven-Vegetable Couscous','MA',1,'Brown the meat with onion and spices, then cover with water and simmer until nearly tender.'),
  ('Seven-Vegetable Couscous','MA',2,'Add the chickpeas and the longer-cooking vegetables (carrot, turnip, pumpkin), and simmer further.'),
  ('Seven-Vegetable Couscous','MA',3,'Add the remaining vegetables (zucchini, tomato) and cook until everything is tender.'),
  ('Seven-Vegetable Couscous','MA',4,'Steam the couscous, fluffing it and moistening with a little broth and olive oil between steamings.'),
  ('Seven-Vegetable Couscous','MA',5,'Mound the couscous on a large platter and arrange the meat and vegetables on top.'),
  ('Seven-Vegetable Couscous','MA',6,'Ladle some of the broth over the dish and serve the rest on the side.'),

  ('Jollof Rice','NG',1,'Blend the tomatoes, bell pepper, onion, and scotch bonnet pepper into a smooth puree.'),
  ('Jollof Rice','NG',2,'Sauté sliced onion in oil, then add the tomato puree, tomato sauce, curry powder, thyme, and bay leaves, and cook until reduced and deep red.'),
  ('Jollof Rice','NG',3,'Add the rinsed rice and stir to coat it in the sauce.'),
  ('Jollof Rice','NG',4,'Pour in enough broth to just cover the rice, cover tightly, and cook on low heat until the rice is tender.'),
  ('Jollof Rice','NG',5,'Stir occasionally, adding a little more liquid if the rice looks dry before it is fully cooked.'),
  ('Jollof Rice','NG',6,'Fluff and serve hot, often alongside chicken, beef, or fried plantain.'),

  ('Egusi Soup','NG',1,'Blend the ground egusi with a little water and chopped onion to form a thick paste.'),
  ('Egusi Soup','NG',2,'Heat the palm oil in a pot and add the locust beans, if using.'),
  ('Egusi Soup','NG',3,'Pour in the broth, then spoon in small portions of the egusi paste, keeping them roughly ball-shaped, and simmer until cooked through.'),
  ('Egusi Soup','NG',4,'Add the cooked meat or fish and the ground crayfish.'),
  ('Egusi Soup','NG',5,'Stir in the chopped leafy greens and simmer until wilted.'),
  ('Egusi Soup','NG',6,'Season to taste and serve with a starchy side such as pounded yam, fufu, or rice.'),

  ('Tacos al Pastor','MX',1,'Blend the achiote paste with garlic, cumin, oregano, pineapple juice, and vinegar into a smooth marinade.'),
  ('Tacos al Pastor','MX',2,'Coat the thinly sliced meat in the marinade and refrigerate for at least 2 hours, or overnight.'),
  ('Tacos al Pastor','MX',3,'Grill or pan-sear the marinated meat until charred at the edges and cooked through.'),
  ('Tacos al Pastor','MX',4,'Grill or sear the pineapple slices alongside until lightly caramelized.'),
  ('Tacos al Pastor','MX',5,'Chop the cooked meat and pineapple into small pieces.'),
  ('Tacos al Pastor','MX',6,'Serve on warmed corn tortillas with diced onion, cilantro, and a squeeze of lime.'),

  ('Mole Poblano','MX',1,'Toast the dried chiles briefly, then soak them in hot water until softened.'),
  ('Mole Poblano','MX',2,'Roast the tomatoes, onion, and garlic until softened and lightly charred.'),
  ('Mole Poblano','MX',3,'Toast the almonds, raisins, sesame seeds, and bread or tortilla, then blend with the spices and a little stock into a smooth paste.'),
  ('Mole Poblano','MX',4,'Blend the soaked chiles separately with a little of their soaking liquid, then strain.'),
  ('Mole Poblano','MX',5,'Fry the chile puree in lard, then stir in the nut-spice paste and the roasted tomato mixture.'),
  ('Mole Poblano','MX',6,'Add stock and the chocolate, and simmer gently until thickened and glossy; serve over cooked chicken or turkey.')
) AS v(dish_name, iso_code, step_number, instruction)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code)
ON CONFLICT (dish_id, step_number) DO NOTHING;


INSERT INTO sources (dish_id, source_type, title, url, publisher)
SELECT d.id, v.source_type, v.title, v.url, v.publisher
FROM (VALUES
  ('Shoyu Ramen','JP','recipe','Shoyu Ramen (from scratch)','https://sudachirecipes.com/wprm_print/12658','Sudachi Recipes'),

  ('Nigiri Sushi','JP','recipe','Simple Nigiri Recipe: How to Make Nigiri Sushi','https://www.masterclass.com/articles/nigiri-recipe','MasterClass'),

  ('Jiaozi (Pork Dumplings)','CN','recipe','Chinese Jiaozi (Pork and Cabbage Dumplings)','https://kitchenstories.com/en/recipes/chinese-jiaozi-pork-and-cabbage-dumplings','Kitchen Stories'),
  ('Jiaozi (Pork Dumplings)','CN','history','Juicy Pork Dumplings You''ll Want To Make Again And Again','https://wherethefoodcomesfrom.com/juicy-pork-dumplings-youll-want-to-make-again-and-again/','Where Food Comes From'),

  ('Kung Pao Chicken','CN','recipe','Kung Pao Chicken (Gong Bao Ji Ding)','https://spicyelement.com/blogs/recipe/kung-pao-chicken','Spicy Element'),

  ('Chicken Tagine with Preserved Lemon & Olives','MA','recipe','Classic Moroccan Chicken Tagine Recipe with Preserved Lemons and Olives','https://grantourismotravels.com/moroccan-chicken-tagine-recipe/','Grantourismo Travels'),

  ('Seven-Vegetable Couscous','MA','recipe','Moroccan 7 Vegetables Couscous','https://www.mymoroccanfood.com/home/moroccan-seven-vegetables-couscous','My Moroccan Food'),
  ('Seven-Vegetable Couscous','MA','history','Authentic Moroccan Couscous Recipe: Seven Vegetables & Spices','https://spice.alibaba.com/spice-basics/moroccan-couscous-recipe','Alibaba Spice'),

  ('Jollof Rice','NG','recipe','Nigerian Jollof Rice Recipe','https://izzycooking.com/?p=23349','Izzy Cooking'),
  ('Jollof Rice','NG','history','Authentic Jollof Rice: Your Ultimate Guide To West Africa''s Beloved Dish','https://wp2.siris.com/trendingentertainment377/jollof-rice-recipe.html','Trending Entertainment'),

  ('Egusi Soup','NG','recipe','Egusi Soup','https://www.chilipeppermadness.com/recipes/egusi-soup','Chili Pepper Madness'),

  ('Tacos al Pastor','MX','recipe','Tacos al Pastor','https://www.dinneratthezoo.com/tacos-al-pastor/','Dinner at the Zoo'),

  ('Mole Poblano','MX','recipe','Mole Poblano Recipe','https://www.willflyforfood.net/mole-poblano-recipe/','Will Fly for Food'),
  ('Mole Poblano','MX','history','Mole Poblano Recipe','https://www.foodrepublic.com/2012/05/04/mole-poblano-recipe','Food Republic')
) AS v(dish_name, iso_code, source_type, title, url, publisher)
JOIN dishes d ON d.name = v.dish_name AND d.country_id = (SELECT id FROM countries WHERE iso_code = v.iso_code);
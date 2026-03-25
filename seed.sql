-- ============================================================
-- seed.sql — Image Gallery Mock Data
-- วิธีรัน:
--   psql "YOUR_DATABASE_URL" -f seed.sql
-- ============================================================


-- ============================================================
-- STEP 1: Create Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS images (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    url         VARCHAR(500) NOT NULL,
    width       INTEGER NOT NULL CHECK (width > 0),
    height      INTEGER NOT NULL CHECK (height > 0),
    description TEXT DEFAULT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS hashtags (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS image_hashtags (
    id         SERIAL PRIMARY KEY,
    image_id   INTEGER NOT NULL REFERENCES images(id) ON DELETE CASCADE,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
    UNIQUE(image_id, hashtag_id)
);

CREATE INDEX IF NOT EXISTS idx_image_hashtags_hashtag_id ON image_hashtags(hashtag_id);
CREATE INDEX IF NOT EXISTS idx_image_hashtags_image_id   ON image_hashtags(image_id);
CREATE INDEX IF NOT EXISTS idx_hashtags_name             ON hashtags(name);
CREATE INDEX IF NOT EXISTS idx_images_created_at         ON images(created_at DESC);


-- ============================================================
-- STEP 2: Clear Old Data
-- ============================================================

TRUNCATE image_hashtags, images, hashtags RESTART IDENTITY CASCADE;


-- ============================================================
-- STEP 3: Insert Hashtags (20 tags)
-- ============================================================

INSERT INTO hashtags (name) VALUES
    ('nature'),
    ('city'),
    ('food'),
    ('travel'),
    ('art'),
    ('technology'),
    ('animals'),
    ('portrait'),
    ('landscape'),
    ('abstract'),
    ('architecture'),
    ('vintage'),
    ('minimalist'),
    ('colorful'),
    ('blackandwhite'),
    ('street'),
    ('fashion'),
    ('sport'),
    ('ocean'),
    ('mountain');


-- ============================================================
-- STEP 4: Insert Images (60 รูป จาก placehold.co)
-- ============================================================
-- รูปแบบ URL: https://placehold.co/{width}x{height}
-- ใช้ขนาดหลากหลายสำหรับ Masonry Layout

INSERT INTO images (title, url, width, height) VALUES
    ('Breathtaking Landscape',   'https://placehold.co/600x400', 600, 400),
    ('Urban Exploration',        'https://placehold.co/400x600', 400, 600),
    ('Golden Hour',              'https://placehold.co/800x600', 800, 600),
    ('Street Life',              'https://placehold.co/500x500', 500, 500),
    ('Deep Forest',              'https://placehold.co/400x300', 400, 300),
    ('City Lights',              'https://placehold.co/900x600', 900, 600),
    ('Ocean Waves',              'https://placehold.co/600x900', 600, 900),
    ('Mountain Peak',            'https://placehold.co/700x450', 700, 450),
    ('Desert Dunes',             'https://placehold.co/450x700', 450, 700),
    ('Autumn Colors',            'https://placehold.co/600x400', 600, 400),
    ('Spring Bloom',             'https://placehold.co/300x400', 300, 400),
    ('Winter Frost',             'https://placehold.co/800x500', 800, 500),
    ('Rainy Day',                'https://placehold.co/500x700', 500, 700),
    ('Sunrise View',             'https://placehold.co/900x600', 900, 600),
    ('Midnight Sky',             'https://placehold.co/600x800', 600, 800),
    ('Ancient Ruins',            'https://placehold.co/700x500', 700, 500),
    ('Modern Architecture',      'https://placehold.co/400x600', 400, 600),
    ('Wild Nature',              'https://placehold.co/500x400', 500, 400),
    ('Quiet Village',            'https://placehold.co/600x400', 600, 400),
    ('Busy Market',              'https://placehold.co/800x600', 800, 600),
    ('Coastal Breeze',           'https://placehold.co/900x500', 900, 500),
    ('Forest Path',              'https://placehold.co/400x700', 400, 700),
    ('City Skyline',             'https://placehold.co/1000x600', 1000, 600),
    ('Hidden Waterfall',         'https://placehold.co/500x800', 500, 800),
    ('Neon Reflections',         'https://placehold.co/700x700', 700, 700),
    ('Rustic Farmhouse',         'https://placehold.co/600x400', 600, 400),
    ('Abstract Geometry',        'https://placehold.co/500x500', 500, 500),
    ('Tropical Beach',           'https://placehold.co/900x600', 900, 600),
    ('Misty Morning',            'https://placehold.co/600x800', 600, 800),
    ('Urban Jungle',             'https://placehold.co/400x500', 400, 500),
    ('Snowy Mountain',           'https://placehold.co/800x600', 800, 600),
    ('Vintage Alley',            'https://placehold.co/500x700', 500, 700),
    ('Desert Sunset',            'https://placehold.co/900x500', 900, 500),
    ('River Flow',               'https://placehold.co/700x400', 700, 400),
    ('Old Town',                 'https://placehold.co/600x600', 600, 600),
    ('Green Valley',             'https://placehold.co/800x500', 800, 500),
    ('Concrete Jungle',          'https://placehold.co/500x600', 500, 600),
    ('Lavender Fields',          'https://placehold.co/900x600', 900, 600),
    ('Night Market',             'https://placehold.co/600x400', 600, 400),
    ('Crystal Lake',             'https://placehold.co/700x500', 700, 500),
    ('Stormy Horizon',           'https://placehold.co/1000x600', 1000, 600),
    ('Cobblestone Street',       'https://placehold.co/400x600', 400, 600),
    ('Golden Fields',            'https://placehold.co/800x500', 800, 500),
    ('Autumn Trail',             'https://placehold.co/500x700', 500, 700),
    ('Hilltop View',             'https://placehold.co/900x600', 900, 600),
    ('Bamboo Forest',            'https://placehold.co/400x800', 400, 800),
    ('Reflective Pool',          'https://placehold.co/600x400', 600, 400),
    ('Wild Grassland',           'https://placehold.co/800x600', 800, 600),
    ('Red Bridge',               'https://placehold.co/700x400', 700, 400),
    ('Emerald Coast',            'https://placehold.co/900x500', 900, 500),
    ('Moonlit Path',             'https://placehold.co/500x700', 500, 700),
    ('Terrace Rice Fields',      'https://placehold.co/800x600', 800, 600),
    ('Canyon View',              'https://placehold.co/1000x500', 1000, 500),
    ('Rainforest Canopy',        'https://placehold.co/600x900', 600, 900),
    ('Salt Flats',               'https://placehold.co/900x600', 900, 600),
    ('Foggy Harbor',             'https://placehold.co/700x500', 700, 500),
    ('Cherry Blossom',           'https://placehold.co/600x400', 600, 400),
    ('Starry Night',             'https://placehold.co/800x600', 800, 600),
    ('Coastal Cliffs',           'https://placehold.co/500x700', 500, 700),
    ('Meadow Morning',           'https://placehold.co/900x600', 900, 600);


-- ============================================================
-- STEP 5: Link Images ↔ Hashtags (image_hashtags)
-- ============================================================
-- hashtag IDs: nature=1, city=2, food=3, travel=4, art=5,
--              technology=6, animals=7, portrait=8, landscape=9,
--              abstract=10, architecture=11, vintage=12, minimalist=13,
--              colorful=14, blackandwhite=15, street=16, fashion=17,
--              sport=18, ocean=19, mountain=20

INSERT INTO image_hashtags (image_id, hashtag_id) VALUES
    -- 1: Breathtaking Landscape
    (1, 9), (1, 1), (1, 4),
    -- 2: Urban Exploration
    (2, 2), (2, 16), (2, 11),
    -- 3: Golden Hour
    (3, 9), (3, 14), (3, 4),
    -- 4: Street Life
    (4, 16), (4, 2), (4, 8),
    -- 5: Deep Forest
    (5, 1), (5, 9), (5, 7),
    -- 6: City Lights
    (6, 2), (6, 14), (6, 11),
    -- 7: Ocean Waves
    (7, 19), (7, 1), (7, 9),
    -- 8: Mountain Peak
    (8, 20), (8, 9), (8, 4),
    -- 9: Desert Dunes
    (9, 9), (9, 4), (9, 13),
    -- 10: Autumn Colors
    (10, 1), (10, 14), (10, 9),
    -- 11: Spring Bloom
    (11, 1), (11, 14), (11, 4),
    -- 12: Winter Frost
    (12, 1), (12, 15), (12, 9),
    -- 13: Rainy Day
    (13, 1), (13, 13), (13, 15),
    -- 14: Sunrise View
    (14, 9), (14, 14), (14, 4),
    -- 15: Midnight Sky
    (15, 9), (15, 15), (15, 13),
    -- 16: Ancient Ruins
    (16, 11), (16, 4), (16, 12),
    -- 17: Modern Architecture
    (17, 11), (17, 2), (17, 13),
    -- 18: Wild Nature
    (18, 1), (18, 7), (18, 9),
    -- 19: Quiet Village
    (19, 4), (19, 12), (19, 9),
    -- 20: Busy Market
    (20, 2), (20, 3), (20, 16),
    -- 21: Coastal Breeze
    (21, 19), (21, 9), (21, 4),
    -- 22: Forest Path
    (22, 1), (22, 9), (22, 13),
    -- 23: City Skyline
    (23, 2), (23, 11), (23, 9),
    -- 24: Hidden Waterfall
    (24, 1), (24, 9), (24, 4),
    -- 25: Neon Reflections
    (25, 2), (25, 14), (25, 5),
    -- 26: Rustic Farmhouse
    (26, 12), (26, 9), (26, 1),
    -- 27: Abstract Geometry
    (27, 10), (27, 5), (27, 14),
    -- 28: Tropical Beach
    (28, 19), (28, 4), (28, 14),
    -- 29: Misty Morning
    (29, 1), (29, 9), (29, 15),
    -- 30: Urban Jungle
    (30, 2), (30, 1), (30, 16),
    -- 31: Snowy Mountain
    (31, 20), (31, 9), (31, 15),
    -- 32: Vintage Alley
    (32, 12), (32, 16), (32, 15),
    -- 33: Desert Sunset
    (33, 9), (33, 14), (33, 4),
    -- 34: River Flow
    (34, 1), (34, 9), (34, 19),
    -- 35: Old Town
    (35, 12), (35, 11), (35, 4),
    -- 36: Green Valley
    (36, 1), (36, 9), (36, 14),
    -- 37: Concrete Jungle
    (37, 2), (37, 11), (37, 15),
    -- 38: Lavender Fields
    (38, 1), (38, 14), (38, 9),
    -- 39: Night Market
    (39, 2), (39, 3), (39, 14),
    -- 40: Crystal Lake
    (40, 1), (40, 9), (40, 19),
    -- 41: Stormy Horizon
    (41, 9), (41, 15), (41, 19),
    -- 42: Cobblestone Street
    (42, 16), (42, 12), (42, 11),
    -- 43: Golden Fields
    (43, 1), (43, 9), (43, 14),
    -- 44: Autumn Trail
    (44, 1), (44, 9), (44, 4),
    -- 45: Hilltop View
    (45, 9), (45, 20), (45, 4),
    -- 46: Bamboo Forest
    (46, 1), (46, 7), (46, 9),
    -- 47: Reflective Pool
    (47, 13), (47, 9), (47, 15),
    -- 48: Wild Grassland
    (48, 1), (48, 7), (48, 9),
    -- 49: Red Bridge
    (49, 11), (49, 4), (49, 14),
    -- 50: Emerald Coast
    (50, 19), (50, 9), (50, 14),
    -- 51: Moonlit Path
    (51, 9), (51, 15), (51, 13),
    -- 52: Terrace Rice Fields
    (52, 1), (52, 9), (52, 4),
    -- 53: Canyon View
    (53, 9), (53, 20), (53, 4),
    -- 54: Rainforest Canopy
    (54, 1), (54, 7), (54, 9),
    -- 55: Salt Flats
    (55, 9), (55, 13), (55, 15),
    -- 56: Foggy Harbor
    (56, 19), (56, 9), (56, 15),
    -- 57: Cherry Blossom
    (57, 1), (57, 14), (57, 4),
    -- 58: Starry Night
    (58, 9), (58, 15), (58, 13),
    -- 59: Coastal Cliffs
    (59, 19), (59, 9), (59, 20),
    -- 60: Meadow Morning
    (60, 1), (60, 9), (60, 14);


-- ============================================================
-- VERIFY
-- ============================================================

SELECT 'images'        AS "table", COUNT(*) AS "rows" FROM images
UNION ALL
SELECT 'hashtags'      AS "table", COUNT(*) AS "rows" FROM hashtags
UNION ALL
SELECT 'image_hashtags'AS "table", COUNT(*) AS "rows" FROM image_hashtags;

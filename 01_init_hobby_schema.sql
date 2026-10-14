-- 1. Create a master lookup table for your tracked activities
CREATE TABLE meta_activities (
	activity_id SERIAL PRIMARY KEY,
	activity_name VARCHAR(50) NOT NULL UNIQUE,
	category VARCHAR(30) NOT NULL, -- e.g., 'Gaming', 'Logic', 'Sports', 'Language'
	created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create a high-precision table to log your daily performance logs
CREATE TABLE daily_metrics_log (
	log_id BIGSERIAL PRIMARY KEY,
	log_date DATE NOT NULL DEFAULT CURRENT_DATE,
	activity_id INT REFERENCES meta_activities(activity_id) ON DELETE RESTRICT,
	numeric_metric_value NUMERIC(8, 2), -- Stores ELO, completion time, win rates, DUPR, etc.,
	text_notes TEXT, -- Notes on strategies or breakthroughs
	recorded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Populate your activity dimensions with seed data
INSERT INTO meta_activities (activity_name, category) VALUES
('Duolingo Chess', 'Logic'),
('LinkedIn Pinpoint', 'Logic'),
('LinkedIn Queens', 'Logic'),
('Pokemon Go', 'Gaming'),
('Mobile Legends', 'Gaming'),
('Pickleball', 'Sports')
ON CONFLICT DO NOTHING;

-- 4. Verify your tables are structured perfectly
SELECT * from meta_activities;

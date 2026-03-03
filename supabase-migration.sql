-- Orchard Dash High Scores Table
-- Run this in your Supabase SQL Editor (https://uopifdvhmqfignffqms.supabase.co)

-- Create the high_scores table
CREATE TABLE high_scores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  player_name TEXT NOT NULL CHECK (char_length(player_name) BETWEEN 1 AND 20),
  score INTEGER NOT NULL CHECK (score >= 0),
  level_reached INTEGER NOT NULL DEFAULT 1 CHECK (level_reached >= 1),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster leaderboard queries
CREATE INDEX high_scores_score_idx ON high_scores(score DESC);

-- Enable Row Level Security
ALTER TABLE high_scores ENABLE ROW LEVEL SECURITY;

-- Allow anyone to view high scores (public leaderboard)
CREATE POLICY "Anyone can view high scores"
  ON high_scores
  FOR SELECT
  USING (true);

-- Allow anyone to submit scores (no auth required)
CREATE POLICY "Anyone can submit scores"
  ON high_scores
  FOR INSERT
  WITH CHECK (true);

-- Optional: Prevent updates/deletes (scores are permanent)
-- No UPDATE or DELETE policies = no one can modify scores

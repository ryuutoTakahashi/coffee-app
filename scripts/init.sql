-- Database initialization script for Coffee Tasting Application

-- Create extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create indexes for better performance
-- User table indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_is_public ON users(is_public);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);

-- Coffee beans table indexes
CREATE INDEX IF NOT EXISTS idx_coffee_beans_origin_country ON coffee_beans(origin_country);
CREATE INDEX IF NOT EXISTS idx_coffee_beans_variety ON coffee_beans(variety);
CREATE INDEX IF NOT EXISTS idx_coffee_beans_processing_method ON coffee_beans(processing_method);

-- Cupping sessions table indexes
CREATE INDEX IF NOT EXISTS idx_cupping_sessions_user_id ON cupping_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_cupping_sessions_coffee_bean_id ON cupping_sessions(coffee_bean_id);
CREATE INDEX IF NOT EXISTS idx_cupping_sessions_is_public ON cupping_sessions(is_public);
CREATE INDEX IF NOT EXISTS idx_cupping_sessions_created_at ON cupping_sessions(created_at);

-- Cupping scores table indexes
CREATE INDEX IF NOT EXISTS idx_cupping_scores_session_id ON cupping_scores(session_id);
CREATE INDEX IF NOT EXISTS idx_cupping_scores_total_score ON cupping_scores(total_score);

-- Session images table indexes
CREATE INDEX IF NOT EXISTS idx_session_images_session_id ON session_images(session_id);

-- Likes table indexes
CREATE INDEX IF NOT EXISTS idx_likes_user_id ON likes(user_id);
CREATE INDEX IF NOT EXISTS idx_likes_session_id ON likes(session_id);

-- Comments table indexes
CREATE INDEX IF NOT EXISTS idx_comments_user_id ON comments(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_session_id ON comments(session_id);
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON comments(created_at);

-- Follows table indexes
CREATE INDEX IF NOT EXISTS idx_follows_follower_id ON follows(follower_id);
CREATE INDEX IF NOT EXISTS idx_follows_following_id ON follows(following_id);

-- Insert sample data (optional - for development)
-- This will be executed only if tables are empty

-- Note: Actual sample data insertion should be done after Spring Boot creates the tables
-- The indexes and constraints will be created here 
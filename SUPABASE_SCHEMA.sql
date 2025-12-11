-- ============================================
-- SUPABASE DATABASE SCHEMA
-- ============================================
-- Run these SQL commands in your Supabase SQL Editor
-- Go to: Supabase Dashboard > SQL Editor > New Query
-- ============================================

-- ============================================
-- 1. PROFILES TABLE
-- ============================================
-- Stores user profile information linked to auth.users
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  avatar TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their own profile
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

-- Policy: Users can update their own profile
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- Policy: Users can insert their own profile
CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Policy: Users can delete their own profile
CREATE POLICY "Users can delete own profile"
  ON profiles FOR DELETE
  USING (auth.uid() = id);

-- ============================================
-- 2. VIDEOS TABLE
-- ============================================
-- Stores video information for each user
CREATE TABLE IF NOT EXISTS videos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  duration TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('processing', 'completed', 'pending', 'failed')),
  filler_words_removed INTEGER DEFAULT 0,
  upload_date DATE NOT NULL DEFAULT CURRENT_DATE,
  thumbnail TEXT,
  original_size TEXT NOT NULL,
  edited_size TEXT,
  progress INTEGER CHECK (progress >= 0 AND progress <= 100),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS videos_user_id_idx ON videos(user_id);
CREATE INDEX IF NOT EXISTS videos_status_idx ON videos(status);
CREATE INDEX IF NOT EXISTS videos_upload_date_idx ON videos(upload_date);

-- Enable Row Level Security
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their own videos
CREATE POLICY "Users can view own videos"
  ON videos FOR SELECT
  USING (auth.uid() = user_id);

-- Policy: Users can insert their own videos
CREATE POLICY "Users can insert own videos"
  ON videos FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policy: Users can update their own videos
CREATE POLICY "Users can update own videos"
  ON videos FOR UPDATE
  USING (auth.uid() = user_id);

-- Policy: Users can delete their own videos
CREATE POLICY "Users can delete own videos"
  ON videos FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================
-- 3. FUNCTION: Auto-create profile on signup
-- ============================================
-- This function automatically creates a profile when a user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NEW.email
  );
  RETURN NEW;
END;
$$;

-- Trigger: Create profile when user signs up
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================
-- 4. FUNCTION: Update updated_at timestamp
-- ============================================
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc'::text, NOW());
  RETURN NEW;
END;
$$;

-- Trigger: Auto-update updated_at for profiles
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- Trigger: Auto-update updated_at for videos
DROP TRIGGER IF EXISTS update_videos_updated_at ON videos;
CREATE TRIGGER update_videos_updated_at
  BEFORE UPDATE ON videos
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- ============================================
-- 5. SAMPLE DATA
-- ============================================
-- This section adds sample video data for testing
-- NOTE: Run this AFTER you have created at least one user account
-- (Sign up through your app first, then run this section)
-- ============================================

-- Function to insert sample videos for the first user
-- This will add 3 sample videos to the first user in your auth.users table
CREATE OR REPLACE FUNCTION public.insert_sample_videos()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  first_user_id UUID;
BEGIN
  -- Get the first user ID from auth.users
  SELECT id INTO first_user_id FROM auth.users ORDER BY created_at ASC LIMIT 1;
  
  -- If no user exists, raise an error
  IF first_user_id IS NULL THEN
    RAISE EXCEPTION 'No users found. Please sign up first, then run this function.';
  END IF;
  
  -- Insert 3 sample videos
  INSERT INTO public.videos (
    user_id,
    name,
    duration,
    status,
    filler_words_removed,
    upload_date,
    thumbnail,
    original_size,
    edited_size,
    progress
  ) VALUES
  (
    first_user_id,
    'Product Demo Video.mp4',
    '5:23',
    'completed',
    42,
    CURRENT_DATE - INTERVAL '5 days',
    'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+1',
    '125 MB',
    '118 MB',
    NULL
  ),
  (
    first_user_id,
    'Marketing Presentation.mov',
    '12:45',
    'processing',
    0,
    CURRENT_DATE - INTERVAL '2 days',
    'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+2',
    '245 MB',
    NULL,
    65
  ),
  (
    first_user_id,
    'Tutorial - Getting Started.mp4',
    '8:12',
    'completed',
    28,
    CURRENT_DATE - INTERVAL '10 days',
    'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+3',
    '89 MB',
    '82 MB',
    NULL
  )
  ON CONFLICT DO NOTHING;
  
  RAISE NOTICE 'Sample videos inserted successfully for user: %', first_user_id;
END;
$$;

-- ============================================
-- TO INSERT SAMPLE DATA:
-- ============================================
-- Option 1: Run this function (recommended)
-- SELECT public.insert_sample_videos();
--
-- Option 2: Insert manually for a specific user
-- First, get your user ID:
-- SELECT id FROM auth.users WHERE email = 'your-email@example.com';
--
-- Then insert videos (replace USER_ID_HERE with your actual user ID):
-- INSERT INTO public.videos (user_id, name, duration, status, filler_words_removed, upload_date, thumbnail, original_size, edited_size)
-- VALUES
--   ('USER_ID_HERE', 'Product Demo Video.mp4', '5:23', 'completed', 42, CURRENT_DATE - 5, 'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+1', '125 MB', '118 MB'),
--   ('USER_ID_HERE', 'Marketing Presentation.mov', '12:45', 'processing', 0, CURRENT_DATE - 2, 'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+2', '245 MB', NULL, 65),
--   ('USER_ID_HERE', 'Tutorial - Getting Started.mp4', '8:12', 'completed', 28, CURRENT_DATE - 10, 'https://via.placeholder.com/160x90/1f2937/ffffff?text=Video+3', '89 MB', '82 MB');
-- ============================================


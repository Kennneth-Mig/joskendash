-- ============================================
-- SUPABASE TABLE SETUP FOR TABLE PAGE
-- ============================================
-- Run these SQL commands in your Supabase SQL Editor
-- This creates the test_table and sets up storage bucket
-- ============================================

-- ============================================
-- 1. CREATE test_table
-- ============================================
CREATE TABLE IF NOT EXISTS test_table (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  data_inputs JSONB NOT NULL DEFAULT '[]'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE test_table ENABLE ROW LEVEL SECURITY;

-- Policy: Authenticated users can view test_table
CREATE POLICY "Users can view test_table"
  ON test_table FOR SELECT
  USING (auth.role() = 'authenticated');

-- Policy: Authenticated users can insert test_table
CREATE POLICY "Users can insert test_table"
  ON test_table FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Policy: Authenticated users can update test_table
CREATE POLICY "Users can update test_table"
  ON test_table FOR UPDATE
  USING (auth.role() = 'authenticated');

-- Policy: Authenticated users can delete test_table
CREATE POLICY "Users can delete test_table"
  ON test_table FOR DELETE
  USING (auth.role() = 'authenticated');

-- ============================================
-- 2. CREATE STORAGE BUCKET
-- ============================================
-- Note: Storage buckets must be created through Supabase Dashboard
-- Go to: Storage > Create Bucket
-- Bucket name: table-images
-- Public: Yes (if you want public URLs)
-- File size limit: 5MB (or as needed)
-- Allowed MIME types: image/png, image/jpeg, image/jpg
--
-- Or use this SQL (if you have the right permissions):
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('table-images', 'table-images', true)
-- ON CONFLICT (id) DO NOTHING;

-- ============================================
-- 3. STORAGE POLICIES
-- ============================================
-- After creating the bucket, set up these policies in Supabase Dashboard:
-- Go to: Storage > table-images > Policies

-- Policy: Allow authenticated users to upload images
-- Policy name: "Allow authenticated uploads"
-- Target roles: authenticated
-- Operation: INSERT
-- Policy definition: true

-- Policy: Allow authenticated users to view images
-- Policy name: "Allow authenticated view"
-- Target roles: authenticated
-- Operation: SELECT
-- Policy definition: true

-- Policy: Allow authenticated users to delete their own images
-- Policy name: "Allow authenticated delete"
-- Target roles: authenticated
-- Operation: DELETE
-- Policy definition: true

-- ============================================
-- 4. FUNCTION: Update updated_at timestamp
-- ============================================
CREATE OR REPLACE FUNCTION public.handle_test_table_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc'::text, NOW());
  RETURN NEW;
END;
$$;

-- Trigger: Auto-update updated_at for test_table
DROP TRIGGER IF EXISTS update_test_table_updated_at ON test_table;
CREATE TRIGGER update_test_table_updated_at
  BEFORE UPDATE ON test_table
  FOR EACH ROW EXECUTE FUNCTION public.handle_test_table_updated_at();

-- ============================================
-- JSON FORMAT FOR data_inputs FIELD:
-- ============================================
-- [
--   {
--     "date": "2024-01-15",
--     "status": "Active",
--     "number": 42,
--     "image": "https://your-project.supabase.co/storage/v1/object/public/table-images/user-id/timestamp.jpg"
--   },
--   {
--     "date": "2024-01-16",
--     "status": "Pending",
--     "number": 100,
--     "image": null
--   }
-- ]
-- ============================================


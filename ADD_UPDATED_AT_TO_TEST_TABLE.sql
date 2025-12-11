-- ============================================
-- ADD updated_at FIELD TO test_table
-- ============================================
-- Run this SQL script in your Supabase SQL Editor
-- This adds the updated_at column and auto-update trigger
-- ============================================

-- ============================================
-- 1. ADD updated_at COLUMN
-- ============================================
-- Add the updated_at column if it doesn't exist
ALTER TABLE test_table
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL;

-- ============================================
-- 2. UPDATE EXISTING ROWS (if any)
-- ============================================
-- Set updated_at to created_at for existing rows (if created_at exists)
-- Or set to current time if created_at doesn't exist
UPDATE test_table
SET updated_at = COALESCE(created_at, TIMEZONE('utc'::text, NOW()))
WHERE updated_at IS NULL;

-- ============================================
-- 3. CREATE FUNCTION: Auto-update updated_at
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

-- ============================================
-- 4. CREATE TRIGGER: Auto-update on UPDATE
-- ============================================
-- Drop trigger if it exists (to avoid conflicts)
DROP TRIGGER IF EXISTS update_test_table_updated_at ON test_table;

-- Create the trigger
CREATE TRIGGER update_test_table_updated_at
  BEFORE UPDATE ON test_table
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_test_table_updated_at();

-- ============================================
-- VERIFICATION
-- ============================================
-- Run this query to verify the column was added:
-- SELECT column_name, data_type, is_nullable, column_default
-- FROM information_schema.columns
-- WHERE table_name = 'test_table' AND column_name = 'updated_at';
-- ============================================


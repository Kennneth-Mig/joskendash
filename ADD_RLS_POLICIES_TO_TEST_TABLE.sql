-- ============================================
-- ADD ROW LEVEL SECURITY POLICIES TO test_table
-- ============================================
-- Run this SQL script in your Supabase SQL Editor
-- This adds RLS policies to allow authenticated users to access test_table
-- ============================================

-- ============================================
-- 1. ENABLE ROW LEVEL SECURITY (if not already enabled)
-- ============================================
ALTER TABLE test_table ENABLE ROW LEVEL SECURITY;

-- ============================================
-- 2. POLICY: Allow authenticated users to SELECT (view)
-- ============================================
-- Drop policy if it exists to avoid conflicts
DROP POLICY IF EXISTS "Users can view test_table" ON test_table;

CREATE POLICY "Users can view test_table"
  ON test_table FOR SELECT
  USING (auth.role() = 'authenticated');

-- ============================================
-- 3. POLICY: Allow authenticated users to INSERT (create)
-- ============================================
-- Drop policy if it exists to avoid conflicts
DROP POLICY IF EXISTS "Users can insert test_table" ON test_table;

CREATE POLICY "Users can insert test_table"
  ON test_table FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- ============================================
-- 4. POLICY: Allow authenticated users to UPDATE (modify)
-- ============================================
-- Drop policy if it exists to avoid conflicts
DROP POLICY IF EXISTS "Users can update test_table" ON test_table;

CREATE POLICY "Users can update test_table"
  ON test_table FOR UPDATE
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- ============================================
-- 5. POLICY: Allow authenticated users to DELETE (remove)
-- ============================================
-- Drop policy if it exists to avoid conflicts
DROP POLICY IF EXISTS "Users can delete test_table" ON test_table;

CREATE POLICY "Users can delete test_table"
  ON test_table FOR DELETE
  USING (auth.role() = 'authenticated');

-- ============================================
-- VERIFICATION
-- ============================================
-- Run this query to verify the policies were created:
-- SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
-- FROM pg_policies
-- WHERE tablename = 'test_table';
-- ============================================


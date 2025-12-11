-- ============================================
-- ADD PUBLIC VIEW POLICY FOR test_table
-- ============================================
-- Run this SQL script in your Supabase SQL Editor
-- This allows public (unauthenticated) users to view specific records
-- ============================================

-- ============================================
-- POLICY: Allow public SELECT on test_table
-- ============================================
-- This policy allows anyone (including unauthenticated users) to read records
-- They can only SELECT (view), not INSERT, UPDATE, or DELETE

DROP POLICY IF EXISTS "Public can view test_table" ON test_table;

CREATE POLICY "Public can view test_table"
  ON test_table FOR SELECT
  USING (true); -- Allow anyone to view any record

-- ============================================
-- IMPORTANT SECURITY NOTES:
-- ============================================
-- 1. This policy only allows SELECT (read) operations
-- 2. Public users CANNOT INSERT, UPDATE, or DELETE
-- 3. Even if someone tries to use the Supabase client in browser console,
--    RLS policies will prevent any write operations
-- 4. Only authenticated users with proper policies can modify data
-- ============================================

-- ============================================
-- VERIFICATION
-- ============================================
-- To verify the policy was created:
-- SELECT schemaname, tablename, policyname, permissive, roles, cmd
-- FROM pg_policies
-- WHERE tablename = 'test_table' AND policyname = 'Public can view test_table';
-- ============================================


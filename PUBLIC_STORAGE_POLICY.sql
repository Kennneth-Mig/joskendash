-- ============================================
-- ADD PUBLIC STORAGE POLICY FOR IMAGE VIEWING
-- ============================================
-- Run this SQL script in your Supabase SQL Editor
-- This allows public users to generate signed URLs for viewing images
-- ============================================

-- ============================================
-- POLICY: Allow public SELECT on table-images bucket
-- ============================================
-- This policy allows public (unauthenticated) users to generate signed URLs
-- They can only SELECT (view/download), not INSERT, UPDATE, or DELETE

-- Note: Storage policies are managed through the Supabase Dashboard
-- Go to: Storage > table-images > Policies
-- 
-- Add a new policy:
-- Policy name: "Public can view images"
-- Target roles: public (or leave empty for all roles)
-- Operation: SELECT
-- Policy definition: true
--
-- This will allow public users to generate signed URLs for viewing images
-- ============================================

-- ============================================
-- ALTERNATIVE: If you want to use SQL directly
-- ============================================
-- Note: Storage policies might need to be created through Dashboard
-- But you can try this SQL:

-- CREATE POLICY "Public can view images"
-- ON storage.objects FOR SELECT
-- USING (bucket_id = 'table-images');

-- ============================================
-- IMPORTANT SECURITY NOTES:
-- ============================================
-- 1. This policy only allows SELECT (view/download) operations
-- 2. Public users CANNOT upload, update, or delete images
-- 3. They can only generate signed URLs to view images
-- 4. Signed URLs expire after the specified time (1 year in our case)
-- ============================================


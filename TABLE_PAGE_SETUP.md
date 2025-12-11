# Table Page Setup Guide

This guide will help you set up the Table page with Supabase integration.

## 📋 Prerequisites

- Supabase project configured
- Environment variables set up in `.env`
- User authentication working

## 🚀 Setup Steps

### 1. Verify Database Table

✅ Your `test_table` already exists with the `data_inputs` JSONB field!

**Optional**: If you need to add RLS policies or triggers, you can run parts of `SUPABASE_TABLE_SETUP.sql`, but the table structure is already correct.

### 2. Create Storage Bucket (PRIVATE)

1. Go to **Storage** in your Supabase Dashboard
2. Click **New Bucket**
3. Configure:
   - **Name**: `table-images`
   - **Public bucket**: ❌ **NO** (Keep it private for authenticated users only)
   - **File size limit**: 5MB (or as needed)
   - **Allowed MIME types**: `image/png, image/jpeg, image/jpg`
4. Click **Create bucket**

**Important**: Keep the bucket **PRIVATE** so only authenticated users can access images via signed URLs.

### 3. Set Up Storage Policies

After creating the bucket, set up policies:

1. Go to **Storage** → `table-images` → **Policies**
2. Click **New Policy**

**Policy 1: Allow Uploads**
- **Policy name**: "Allow authenticated uploads"
- **Target roles**: `authenticated`
- **Operation**: `INSERT`
- **Policy definition**: `true`

**Policy 2: Allow Viewing**
- **Policy name**: "Allow authenticated view"
- **Target roles**: `authenticated`
- **Operation**: `SELECT`
- **Policy definition**: `true`

**Policy 3: Allow Deletion**
- **Policy name**: "Allow authenticated delete"
- **Target roles**: `authenticated`
- **Operation**: `DELETE`
- **Policy definition**: `true`

### 4. Verify Table Access (Optional)

If you want to ensure proper access control, you can add RLS policies to `test_table`:

1. Go to **Table Editor** → `test_table` → **Policies**
2. Add policies for authenticated users to SELECT, INSERT, UPDATE, DELETE

**Note**: If your table already has data or specific access requirements, adjust policies accordingly.

## 📊 How It Works

### Table Structure

The table displays data with these columns:
- **Date**: Date picker input
- **Status**: Text input
- **Number**: Number input
- **Image**: File upload (PNG/JPEG) to Supabase Storage
- **Actions**: Edit and Delete icons

### Data Storage Format

Data is stored in the `test_table` in the `data_inputs` field as JSON:

```json
[
  {
    "date": "2024-01-15",
    "status": "Active",
    "number": 42,
    "image": "https://your-project.supabase.co/storage/v1/object/public/table-images/user-id/timestamp.jpg"
  },
  {
    "date": "2024-01-16",
    "status": "Pending",
    "number": 100,
    "image": null
  }
]
```

### Features

✅ **Add Row**: Click "Add Row" to add a new entry
✅ **Edit Row**: Click the edit icon to modify a row
✅ **Delete Row**: Click the delete icon to remove a row
✅ **Image Upload**: Upload PNG/JPEG images that are stored in Supabase Storage
✅ **Save Changes**: Click "Save Changes" to persist all data to the database

## 🧪 Testing

1. Navigate to `/table` in your app
2. Click **Add Row**
3. Fill in:
   - Date: Select a date
   - Status: Enter any text (e.g., "Active")
   - Number: Enter a number (e.g., 42)
   - Image: Upload a PNG or JPEG file
4. Click the save icon (✓) in the row
5. Add more rows if needed
6. Click **Save Changes** button at the top
7. Refresh the page - your data should persist!

## 🔒 Security

- ✅ Row Level Security enabled on `test_table`
- ✅ Only authenticated users can access the table
- ✅ Storage policies restrict access to authenticated users only
- ✅ Images are stored securely in Supabase Storage

## 🐛 Troubleshooting

### Issue: "Failed to upload image"
- **Solution**: Check that the `table-images` bucket exists and policies are set correctly

### Issue: "Failed to save changes"
- **Solution**: Verify the `test_table` was created successfully and RLS policies are enabled

### Issue: Images not displaying
- **Solution**: Ensure the bucket is set to **Public** or update the storage policies

### Issue: "User not authenticated"
- **Solution**: Make sure you're logged in and the session is valid

## 📝 Notes

- The table stores all rows in a single record in `test_table`
- Each time you click "Save Changes", it updates the entire `data_inputs` JSON array
- Images are uploaded immediately when selected, before saving the row
- Image URLs are stored in the JSON data structure


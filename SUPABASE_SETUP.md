# Supabase Setup Guide

This guide will help you set up Supabase for your DashClip application.

## 📋 Prerequisites

- A Supabase account (sign up at https://supabase.com)
- Your Supabase project created
- Environment variables configured in `.env` file

## 🚀 Step-by-Step Setup

### 1. Create Database Tables

1. Go to your Supabase Dashboard: https://app.supabase.com
2. Select your project
3. Navigate to **SQL Editor** (in the left sidebar)
4. Click **New Query**
5. Copy and paste the entire contents of `SUPABASE_SCHEMA.sql` file
6. Click **Run** (or press `Ctrl+Enter`)

This will create:
- ✅ `profiles` table (user profiles)
- ✅ `videos` table (video data)
- ✅ Row Level Security (RLS) policies
- ✅ Automatic triggers for profile creation and timestamps

### 2. Verify Tables Were Created

1. Go to **Table Editor** in your Supabase dashboard
2. You should see two tables:
   - `profiles`
   - `videos`

### 3. Enable Email Authentication (if not already enabled)

1. Go to **Authentication** > **Providers** in your Supabase dashboard
2. Make sure **Email** provider is enabled
3. Configure email settings if needed (SMTP, email templates, etc.)

### 4. Test Your Setup

1. Start your development server:
   ```bash
   npm run dev
   ```

2. Navigate to the signup page
3. Create a test account
4. Try logging in with your credentials

## 🔒 Security Features

The database schema includes:
- **Row Level Security (RLS)**: Users can only access their own data
- **Automatic profile creation**: Profiles are created when users sign up
- **Secure authentication**: Uses Supabase Auth with email/password

## 📊 Database Schema

### `profiles` Table
- `id` (UUID, Primary Key) - References auth.users
- `name` (TEXT) - User's full name
- `email` (TEXT) - User's email
- `avatar` (TEXT, Optional) - Avatar URL
- `created_at` (TIMESTAMP) - Account creation date
- `updated_at` (TIMESTAMP) - Last update date

### `videos` Table
- `id` (UUID, Primary Key) - Video ID
- `user_id` (UUID) - References auth.users
- `name` (TEXT) - Video filename
- `duration` (TEXT) - Video duration (e.g., "5:30")
- `status` (TEXT) - Video status: 'processing', 'completed', 'pending', 'failed'
- `filler_words_removed` (INTEGER) - Count of removed filler words
- `upload_date` (DATE) - Upload date
- `thumbnail` (TEXT) - Thumbnail URL
- `original_size` (TEXT) - Original file size (e.g., "150 MB")
- `edited_size` (TEXT, Optional) - Edited file size
- `progress` (INTEGER, Optional) - Processing progress (0-100)
- `created_at` (TIMESTAMP) - Creation timestamp
- `updated_at` (TIMESTAMP) - Last update timestamp

## 🐛 Troubleshooting

### Issue: "Missing Supabase environment variables"
- **Solution**: Make sure your `.env` file exists and contains:
  - `VITE_SUPABASE_URL`
  - `VITE_SUPABASE_ANON_KEY`

### Issue: "Failed to fetch videos"
- **Solution**: 
  1. Check that tables were created successfully
  2. Verify RLS policies are enabled
  3. Check browser console for specific error messages

### Issue: "Authentication failed"
- **Solution**:
  1. Verify email provider is enabled in Supabase
  2. Check that your Supabase URL and keys are correct
  3. Make sure you're using the **Publishable key** (not the secret key)

### Issue: "Row Level Security policy violation"
- **Solution**: Make sure you ran the entire `SUPABASE_SCHEMA.sql` file, including the RLS policies

## 📝 Next Steps

After setup:
1. ✅ Test user registration
2. ✅ Test user login
3. ✅ Test video upload
4. ✅ Test video CRUD operations
5. ✅ Verify data persistence (refresh page, data should remain)

## 🔗 Useful Links

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Auth Guide](https://supabase.com/docs/guides/auth)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)


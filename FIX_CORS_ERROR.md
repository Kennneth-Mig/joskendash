# Fix CORS Error for Supabase Storage

## 🔴 Problem
You're seeing CORS errors in the console:
```
Access to fetch at 'https://...supabase.co/storage/v1...' from origin 'http://localhost:3000' 
has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present
```

## ✅ Solution

### Option 1: Configure CORS in Supabase Dashboard (Recommended)

1. **Go to Supabase Dashboard**
   - Navigate to your project
   - Click on **Storage** in the left sidebar

2. **Select your bucket**
   - Click on the `table-images` bucket

3. **Configure CORS**
   - Look for **Settings** or **Configuration** tab
   - Find **CORS Configuration** section
   - Add your localhost origin:
     ```
     http://localhost:3000
     ```
   - For production, also add your production domain:
     ```
     https://yourdomain.com
     ```
   - Click **Save**

### Option 2: Use Supabase API Settings

1. **Go to Supabase Dashboard**
   - Navigate to **Settings** → **API**

2. **Check CORS Settings**
   - Look for **CORS Configuration** or **Allowed Origins**
   - Add `http://localhost:3000` to the allowed origins list
   - Save changes

### Option 3: Make Bucket Public (Less Secure - Not Recommended)

⚠️ **Warning**: This makes all images publicly accessible without signed URLs.

1. **Go to Storage** → `table-images` bucket
2. **Edit bucket settings**
3. **Enable "Public bucket"**
4. **Save**

Then update your code to use public URLs instead of signed URLs.

## 🔍 Verify Fix

After configuring CORS:
1. **Restart your development server**
2. **Refresh the browser**
3. **Check the console** - CORS errors should be gone
4. **Images should load** properly

## 📝 Notes

- **CORS errors** prevent the browser from loading resources from a different origin
- **Signed URLs** require proper CORS configuration to work
- **Localhost** needs to be explicitly allowed in CORS settings
- **Production** will need your production domain added to CORS settings

## 🆘 If Still Not Working

1. **Check browser console** for specific error messages
2. **Verify bucket name** is correct (`table-images`)
3. **Check storage policies** - ensure SELECT policy exists for authenticated users
4. **Verify environment variables** are set correctly
5. **Try clearing browser cache** and hard refresh (Ctrl+Shift+R)


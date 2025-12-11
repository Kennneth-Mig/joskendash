# Supabase Edge Functions Guide

## 🚀 What are Edge Functions?

**Edge Functions** are serverless functions that run on Supabase's edge network (close to your users). They allow you to:
- Run custom server-side code
- Access your Supabase database securely
- Send emails, SMS, or other notifications
- Integrate with third-party APIs
- Process data before saving to database
- Trigger webhooks

## 📧 Email Notifications Setup

### Step 1: Create an Edge Function

1. **Go to Supabase Dashboard**
   - Navigate to **Edge Functions** (left sidebar)
   - Click **"Create a new function"** or use a template

2. **Use the "Send Emails" template**
   - Click on **"Send Emails"** template
   - This uses the Resend API (recommended for email)

### Step 2: Set Up Resend API (Email Service)

1. **Sign up for Resend** (free tier available)
   - Go to https://resend.com
   - Sign up for a free account
   - Get your API key from the dashboard

2. **Add API Key to Supabase Secrets**
   - In Supabase Dashboard → **Edge Functions** → **Secrets**
   - Click **"Add a new secret"**
   - Name: `RESEND_API_KEY`
   - Value: Your Resend API key
   - Click **Save**

### Step 3: Verify Your Email Domain (Optional)

- For production, verify your domain in Resend
- For testing, you can use Resend's test domain

## 🔔 Setting Up Immediate Notifications

### Option 1: Database Trigger (Recommended)
Trigger an Edge Function automatically when data changes in your database.

### Option 2: Call from Frontend
Call the Edge Function directly from your React app when needed.

## 📝 Example: Notify on New Table Row

We'll create an Edge Function that sends an email when a new row is added to `test_table`.




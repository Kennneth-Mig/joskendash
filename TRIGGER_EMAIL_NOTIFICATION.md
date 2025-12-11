# How to Trigger Email Notifications

## 🎯 Two Ways to Send Email Notifications

### Option 1: Database Trigger (Automatic) ⭐ Recommended

Automatically send an email whenever a new row is added to `test_table`.

#### Step 1: Create Database Function

Run this SQL in Supabase SQL Editor:

```sql
-- Function to call Edge Function when new row is added
CREATE OR REPLACE FUNCTION public.notify_new_table_row()
RETURNS TRIGGER AS $$
BEGIN
  -- Call Edge Function via HTTP
  PERFORM
    net.http_post(
      url := current_setting('app.supabase_url') || '/functions/v1/send-notification',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || current_setting('app.supabase_anon_key')
      ),
      body := jsonb_build_object(
        'recordId', NEW.id,
        'recordData', NEW.data_inputs,
        'recipientEmail', 'your-email@example.com' -- CHANGE THIS!
      )
    );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger
DROP TRIGGER IF EXISTS trigger_notify_new_table_row ON test_table;
CREATE TRIGGER trigger_notify_new_table_row
  AFTER INSERT ON test_table
  FOR EACH ROW
  EXECUTE FUNCTION public.notify_new_table_row();
```

**⚠️ Important:** Replace `'your-email@example.com'` with your actual email address!

#### Step 2: Set Up HTTP Extension (if needed)

If `net.http_post` doesn't work, you may need to enable the `http` extension:

```sql
CREATE EXTENSION IF NOT EXISTS http;
```

### Option 2: Call from Frontend (Manual)

Call the Edge Function directly from your React app when a row is added.

#### Update `tableStore.ts`

Add this function to call the Edge Function:

```typescript
// In tableStore.ts, add this to the saveChanges function
const sendNotification = async (recordId: string) => {
  try {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) return;

    const response = await fetch(
      `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/send-notification`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({
          recordId,
          recipientEmail: 'your-email@example.com', // CHANGE THIS!
        }),
      }
    );

    if (!response.ok) {
      console.warn('Failed to send notification:', await response.text());
    }
  } catch (error) {
    console.warn('Notification error (non-critical):', error);
  }
};
```

## 🚀 Deployment Steps

### 1. Install Supabase CLI (if not installed)

```bash
npm install -g supabase
```

### 2. Login to Supabase

```bash
supabase login
```

### 3. Link Your Project

```bash
supabase link --project-ref your-project-ref
```

### 4. Deploy the Function

```bash
supabase functions deploy send-notification
```

### 5. Set Environment Variables

```bash
supabase secrets set RESEND_API_KEY=your_resend_api_key_here
```

## 📧 Alternative: Use Supabase's Built-in Email

If you don't want to use Resend, you can use Supabase's built-in email service (limited) or other services like:
- **SendGrid**
- **Mailgun**
- **AWS SES**
- **Postmark**

## 🔔 Customization

### Change Email Template

Edit `supabase/functions/send-notification/index.ts` to customize:
- Email subject
- Email HTML template
- What data to include
- Email styling

### Multiple Recipients

Modify the function to accept an array of emails:

```typescript
to: [recipientEmail, 'another@email.com'],
```

### Conditional Notifications

Only send emails for specific conditions:

```typescript
// Only send if status is "Completed"
if (rowData.status === 'Completed') {
  // Send email
}
```

## 🧪 Testing

### Test the Function Locally

```bash
supabase functions serve send-notification
```

### Test via Dashboard

1. Go to **Edge Functions** → `send-notification`
2. Click **"Invoke function"**
3. Use this test payload:

```json
{
  "recordId": "your-record-id",
  "recipientEmail": "your-email@example.com"
}
```

## ⚠️ Important Notes

1. **Rate Limits**: Resend free tier has limits (3,000 emails/month)
2. **Domain Verification**: For production, verify your domain in Resend
3. **Security**: Never expose API keys in frontend code
4. **Error Handling**: Edge Functions should handle errors gracefully
5. **Costs**: Edge Functions have usage limits on free tier

## 🎉 Next Steps

1. Set up Resend account
2. Deploy the Edge Function
3. Choose Option 1 (automatic) or Option 2 (manual)
4. Test with a new row
5. Check your email!




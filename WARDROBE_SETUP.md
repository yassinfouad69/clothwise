# Wardrobe Feature Setup Guide

This guide will help you set up the wardrobe feature with camera integration and Supabase cloud storage.

## Features

- **Camera Integration**: Take photos directly from your mobile camera
- **Gallery Upload**: Choose existing photos from your gallery
- **Cloud Storage**: Store images securely in Supabase
- **Real-time Sync**: All items sync across devices
- **Category Filtering**: Filter by clothing categories (Topwear, Bottomwear, Footwear, etc.)

## Setup Instructions

### 1. Create a Supabase Account

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up for a free account
3. Create a new project

### 2. Get Your Supabase Credentials

1. In your Supabase project dashboard, go to **Settings > API**
2. Copy your **Project URL**
3. Copy your **anon/public key**

### 3. Configure Supabase in the App

1. Open `lib/src/core/config/supabase_config.dart`
2. Replace `YOUR_SUPABASE_URL` with your Project URL
3. Replace `YOUR_SUPABASE_ANON_KEY` with your anon key

Example:
```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';

  static const String wardrobeBucket = 'wardrobe-items';
}
```

### 4. Create Storage Bucket in Supabase

1. In your Supabase dashboard, go to **Storage**
2. Click **New bucket**
3. Name it: `wardrobe-items`
4. Make it **public** (or configure RLS policies if you want authentication)
5. Click **Create bucket**

### 5. Create Database Table

1. In your Supabase dashboard, go to **SQL Editor**
2. Run this SQL command:

```sql
CREATE TABLE wardrobe_items (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  color TEXT NOT NULL,
  usage TEXT NOT NULL,
  image_url TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (optional, for user-specific data)
ALTER TABLE wardrobe_items ENABLE ROW LEVEL SECURITY;

-- Create a policy to allow all operations (for testing)
-- You should modify this for production to use authentication
CREATE POLICY "Allow all operations" ON wardrobe_items
  FOR ALL
  USING (true)
  WITH CHECK (true);
```

### 6. Configure Mobile Permissions

#### For Android (android/app/src/main/AndroidManifest.xml)

Add these permissions inside the `<manifest>` tag:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
    android:maxSdkVersion="28"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

#### For iOS (ios/Runner/Info.plist)

Add these keys inside the `<dict>` tag:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos of clothing items</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select clothing images</string>
```

### 7. Run the App

```bash
flutter pub get
flutter run
```

## How to Use

### Adding a New Item

1. Open the app and navigate to the **Wardrobe** tab
2. Tap the **+** floating action button
3. Choose to either:
   - **Take Photo**: Opens camera to capture new photo
   - **Choose from Gallery**: Select existing photo
4. Fill in the item details:
   - **Name**: e.g., "Blue Denim Shirt"
   - **Color**: e.g., "Blue"
   - **Category**: Select from Topwear, Bottomwear, Footwear, Accessory, or One-piece
   - **Usage**: Select from Casual, Formal, or Sport
5. Tap **Save Item**

### Viewing Your Wardrobe

- All items appear in a grid layout
- Use category filters at the top to filter by clothing type
- Use the search bar to find specific items

### What Gets Stored

- **Supabase Storage**: Actual image files
- **Supabase Database**: Item metadata (name, color, category, usage, image URL)

## Troubleshooting

### Images Not Uploading

1. Check your internet connection
2. Verify Supabase credentials in `supabase_config.dart`
3. Ensure the `wardrobe-items` bucket exists and is public
4. Check Supabase dashboard for any error logs

### Camera Not Working

1. Check that camera permissions are added in AndroidManifest.xml (Android) or Info.plist (iOS)
2. On physical device, ensure camera permissions are granted in app settings
3. Note: Camera won't work in iOS Simulator (use gallery instead)

### Database Errors

1. Verify the `wardrobe_items` table exists in Supabase
2. Check that RLS policies allow the operations
3. View SQL logs in Supabase dashboard

## Cost

- Supabase free tier includes:
  - 500MB database storage
  - 1GB file storage
  - 50MB file uploads
  - Bandwidth limits

This is sufficient for hundreds of clothing items with compressed images.

## Security Notes (Production)

For production apps, you should:

1. Implement user authentication
2. Configure proper RLS (Row Level Security) policies
3. Add user_id to wardrobe_items table
4. Restrict storage bucket access to authenticated users only

Example RLS policy with authentication:

```sql
-- Allow users to see only their own items
CREATE POLICY "Users can view own items" ON wardrobe_items
  FOR SELECT
  USING (auth.uid()::text = user_id);

-- Allow users to insert only their own items
CREATE POLICY "Users can insert own items" ON wardrobe_items
  FOR INSERT
  WITH CHECK (auth.uid()::text = user_id);
```

## Next Steps

After setting up the wardrobe feature, you can:

1. Integrate AI outfit recommendations based on wardrobe items
2. Add outfit creation by combining multiple items
3. Implement sharing features
4. Add analytics for most worn items
5. Create virtual try-on features

/// Supabase configuration
///
/// To set up Supabase:
/// 1. Go to https://supabase.com and create a new project
/// 2. Go to Project Settings > API
/// 3. Copy your Project URL and anon/public key
/// 4. Create a storage bucket named 'wardrobe-items' in Storage
/// 5. Set the bucket to public or configure RLS policies
class SupabaseConfig {
  static const String supabaseUrl = 'https://hxandtdibhkjwzcjedkp.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4YW5kdGRpYmhrand6Y2plZGtwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE5NjAwNTcsImV4cCI6MjA3NzUzNjA1N30.ZqeDWifi3I-ShqwYWzFXE2SvA1YXXRmOIG7oecSo6Is';

  // Storage bucket name for wardrobe items
  static const String wardrobeBucket = 'wardrobe-items';
}

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;

  SupabaseService._internal();

  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://anxbrjwccffjnmqiobwg.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFueGJyandjY2Zmam5tcWlvYndnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQzODA3ODMsImV4cCI6MjA0OTk1Njc4M30.bbLlHVN2WZ-BLqph9XQKFpTjj5V9oQNbK22l8Kz_BVg',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
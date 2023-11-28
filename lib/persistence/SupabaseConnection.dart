import 'package:supabase/supabase.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseClient? _client;

  SupabaseService._internal();

  Future<void> initialize() async {

    _client = SupabaseClient(
        'https://whxrdxkwesgagitztfce.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndoeHJkeGt3ZXNnYWdpdHp0ZmNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg2MjAwMjAsImV4cCI6MjAxNDE5NjAyMH0.IAzAGOKBtEjz7QGItwNn8JLR7i8P9gVNwYUBuAVYO94');

    final response = await _client!.from('usuario').select();
    if (response == null) {
      print('Error al conectar a Supabase');
    } else {
      print('Conexión a Supabase exitosa');
    }
  }

  SupabaseClient get client {
    assert(_client != null, 'La conexión a Supabase no ha sido inicializada.');
    return _client!;
  }
}
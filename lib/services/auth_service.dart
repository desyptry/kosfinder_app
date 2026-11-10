
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  // Mengambil data pengguna yang sedang login
  User? get currentUser => _client.auth.currentUser;

  // Memeriksa session pengguna
  Session? get currentSession => _client.auth.currentSession;

  bool get isLoggedIn => currentSession != null;

  // Registrasi akun
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Login akun
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Logout akun
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}

class ApiConfig {
  // Remplace par l'URL de ton backend Laravel
  static const String baseUrl = 'http://192.168.1.137:8000/api';

  // Endpoints d'authentification (corrigés selon tes routes Laravel)
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String logoutEndpoint = '$baseUrl/auth/logout';
  static const String userEndpoint = '$baseUrl/user'; // Route protégée

  // Headers par défaut
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Headers avec token d'authentification
  static Map<String, String> authHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };
}

/*import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/api_config.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Variables d'état
  String? _token;
  User? _user;

  // Getters
  String? get token => _token;
  User? get user => _user;
  bool get isAuthenticated => _token != null && _user != null;

  // Initialiser le service (à appeler au démarrage de l'app)
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);

    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        _user = User.fromJson(json.decode(userJson));
      } catch (e) {
        // Si erreur de parsing, nettoyer les données
        await logout();
      }
    }
  }

  // Connexion
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginEndpoint),
        headers: ApiConfig.defaultHeaders,
        body: json.encode({'email': email, 'mot_de_passe': password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(data);

        // Sauvegarder les données d'authentification
        await _saveAuthData(authResponse.token, authResponse.user);

        return authResponse;
      } else {
        throw ApiError.fromJson(data);
      }
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError(message: 'Erreur de connexion: ${e.toString()}');
    }
  }

  // Inscription
  Future<AuthResponse> register({
    required String nom,
    required String prenom,
    required String email,
    required String telephone,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.registerEndpoint),
        headers: ApiConfig.defaultHeaders,
        body: json.encode({
          'nom': nom,
          'prenom': prenom,
          'email': email,
          'telephone': telephone,
          'mot_de_passe': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(data);

        // Sauvegarder les données d'authentification
        await _saveAuthData(authResponse.token, authResponse.user);

        return authResponse;
      } else {
        throw ApiError.fromJson(data);
      }
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError(message: 'Erreur d\'inscription: ${e.toString()}');
    }
  }

  // Déconnexion
  Future<void> logout() async {
    try {
      if (_token != null) {
        await http.post(
          Uri.parse(ApiConfig.logoutEndpoint),
          headers: ApiConfig.authHeaders(_token!),
        );
      }
    } catch (e) {
      // Même si la déconnexion côté serveur échoue, on nettoie localement
      print('Erreur lors de la déconnexion: $e');
    } finally {
      await _clearAuthData();
    }
  }

  // Vérifier si le token est encore valide
  Future<bool> validateToken() async {
    if (_token == null) return false;

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.userEndpoint),
        headers: ApiConfig.authHeaders(_token!),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = User.fromJson(data);
        return true;
      } else {
        await _clearAuthData();
        return false;
      }
    } catch (e) {
      await _clearAuthData();
      return false;
    }
  }

  // Sauvegarder les données d'authentification
  Future<void> _saveAuthData(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();

    _token = token;
    _user = user;

    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, json.encode(user.toJson()));
  }

  // Nettoyer les données d'authentification
  Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();

    _token = null;
    _user = null;

    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // Formater les erreurs de validation
  String formatValidationErrors(ApiError error) {
    if (error.errors == null || error.errors!.isEmpty) {
      return error.message;
    }

    List<String> messages = [];
    error.errors!.forEach((field, fieldErrors) {
      messages.addAll(fieldErrors);
    });

    return messages.join('\n');
  }
}*/
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/api_config.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Variables d'état
  String? _token;
  User? _user;

  // Getters
  String? get token => _token;
  User? get user => _user;
  bool get isAuthenticated => _token != null && _user != null;

  // Initialiser le service (à appeler au démarrage de l'app)
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);

    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        _user = User.fromJson(json.decode(userJson));
      } catch (e) {
        // Si erreur de parsing, nettoyer les données
        await logout();
      }
    }
  }

  // Connexion - CORRIGÉE pour Laravel API Response
  Future<AuthResponse> login(String email, String password) async {
    try {
      print('🔄 Tentative de connexion...');
      print('Email: $email');
      print('Password: ${password.replaceAll(RegExp(r'.'), '*')}'); // Masquer le mot de passe dans les logs

      final response = await http.post(
        Uri.parse(ApiConfig.loginEndpoint),
        headers: ApiConfig.defaultHeaders,
        body: json.encode({
          'email': email,
          'mot_de_passe': password, // Utiliser 'password' au lieu de 'mot_de_passe'
        }),
      );

      print('📡 Status Code: ${response.statusCode}');
      print('📡 Response Headers: ${response.headers}');
      print('📡 Response Body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Traiter la réponse Laravel
        final laravelResponse = LaravelApiResponse.fromJson(data);
        
        print('✅ Laravel Response Success: ${laravelResponse.success}');
        print('✅ Laravel Response Message: ${laravelResponse.message}');
        
        if (laravelResponse.success && laravelResponse.data != null) {
          print('✅ Data présente, création AuthResponse...');
          
          // Extraire le token et l'utilisateur
          final token = laravelResponse.data!.token;
          final user = laravelResponse.data!.utilisateur;
          
          print('✅ Token: ${token.substring(0, 10)}...');
          print('✅ User: ${user.toString()}');

          // Créer AuthResponse pour compatibilité
          final authResponse = AuthResponse(
            token: token,
            user: user,
          );

          // Sauvegarder les données d'authentification
          await _saveAuthData(token, user);
          
          print('✅ Données sauvegardées avec succès!');
          print('✅ isAuthenticated: $isAuthenticated');

          return authResponse;
        } else {
          print('❌ Réponse Laravel sans succès ou sans data');
          throw ApiError(message: laravelResponse.message);
        }
      } else {
        print('❌ Status Code différent de 200');
        // Essayer de parser comme une erreur Laravel
        try {
          final errorResponse = LaravelApiResponse.fromJson(data);
          throw ApiError(
            message: errorResponse.message,
            errors: errorResponse.errors?.map(
              (key, value) => MapEntry(key, [value.toString()]),
            ),
          );
        } catch (parseError) {
          // Si impossible de parser, utiliser le message générique
          throw ApiError(
            message: data['message']?.toString() ?? 'Erreur de connexion (${response.statusCode})',
          );
        }
      }
    } catch (e) {
      print('❌ Erreur complète dans login: $e');
      print('❌ Type d\'erreur: ${e.runtimeType}');
      
      if (e is ApiError) {
        rethrow;
      }
      
      // Gérer les erreurs de réseau ou autres
      if (e.toString().contains('SocketException') || 
          e.toString().contains('TimeoutException')) {
        throw ApiError(message: 'Problème de connexion réseau. Vérifiez votre connexion internet.');
      }
      
      throw ApiError(message: 'Erreur de connexion: ${e.toString()}');
    }
  }

  // Inscription - CORRIGÉE pour Laravel API Response
  Future<AuthResponse> register({
    required String nom,
    required String prenom,
    required String email,
    required String telephone,
    required String password,
  }) async {
    try {
      print('🔄 Tentative d\'inscription...');
      
      final response = await http.post(
        Uri.parse(ApiConfig.registerEndpoint),
        headers: ApiConfig.defaultHeaders,
        body: json.encode({
          'nom': nom,
          'prenom': prenom,
          'email': email,
          'telephone': telephone,
          'password': password,
        }),
      );

      print('📡 Register Status Code: ${response.statusCode}');
      print('📡 Register Response: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final laravelResponse = LaravelApiResponse.fromJson(data);
        
        if (laravelResponse.success && laravelResponse.data != null) {
          final authResponse = AuthResponse(
            token: laravelResponse.data!.token,
            user: laravelResponse.data!.utilisateur,
          );

          await _saveAuthData(authResponse.token, authResponse.user);
          return authResponse;
        } else {
          throw ApiError(message: laravelResponse.message);
        }
      } else {
        try {
          final errorResponse = LaravelApiResponse.fromJson(data);
          throw ApiError(
            message: errorResponse.message,
            errors: errorResponse.errors?.map(
              (key, value) => MapEntry(key, [value.toString()]),
            ),
          );
        } catch (parseError) {
          throw ApiError(
            message: data['message']?.toString() ?? 'Erreur d\'inscription (${response.statusCode})',
          );
        }
      }
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError(message: 'Erreur d\'inscription: ${e.toString()}');
    }
  }

  // Déconnexion
  Future<void> logout() async {
    try {
      if (_token != null) {
        await http.post(
          Uri.parse(ApiConfig.logoutEndpoint),
          headers: ApiConfig.authHeaders(_token!),
        );
      }
    } catch (e) {
      print('Erreur lors de la déconnexion côté serveur: $e');
    } finally {
      await _clearAuthData();
      print('✅ Déconnexion locale effectuée');
    }
  }

  // Vérifier si le token est encore valide
  Future<bool> validateToken() async {
    if (_token == null) {
      print('❌ Aucun token pour validation');
      return false;
    }

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.userEndpoint),
        headers: ApiConfig.authHeaders(_token!),
      );

      print('🔍 Validation token status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Adapter selon la structure de votre API
        if (data is Map<String, dynamic>) {
          if (data['success'] == true && data['data'] != null) {
            _user = User.fromJson(data['data']);
          } else if (data.containsKey('id')) {
            // Si l'utilisateur est directement dans la réponse
            _user = User.fromJson(data);
          }
        }
        
        print('✅ Token valide, utilisateur: ${_user?.toString()}');
        return true;
      } else {
        print('❌ Token invalide, nettoyage...');
        await _clearAuthData();
        return false;
      }
    } catch (e) {
      print('❌ Erreur validation token: $e');
      await _clearAuthData();
      return false;
    }
  }

  // Sauvegarder les données d'authentification
  Future<void> _saveAuthData(String token, User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _token = token;
      _user = user;

      await prefs.setString(_tokenKey, token);
      await prefs.setString(_userKey, json.encode(user.toJson()));
      
      print('💾 Données auth sauvegardées:');
      print('💾 Token: ${token.substring(0, 10)}...');
      print('💾 User ID: ${user.id}');
      print('💾 User Email: ${user.email}');
    } catch (e) {
      print('❌ Erreur sauvegarde auth: $e');
      throw ApiError(message: 'Erreur de sauvegarde des données d\'authentification');
    }
  }

  // Nettoyer les données d'authentification
  Future<void> _clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _token = null;
      _user = null;

      await prefs.remove(_tokenKey);
      await prefs.remove(_userKey);
      
      print('🧹 Données auth nettoyées');
    } catch (e) {
      print('❌ Erreur nettoyage auth: $e');
    }
  }

  // Formater les erreurs de validation
  String formatValidationErrors(ApiError error) {
    if (error.errors == null || error.errors!.isEmpty) {
      return error.message;
    }

    List<String> messages = [error.message];
    error.errors!.forEach((field, fieldErrors) {
      messages.addAll(fieldErrors.map((err) => '• $err'));
    });

    return messages.join('\n');
  }

  // Méthode utilitaire pour vérifier la connexion réseau
  Future<bool> checkConnectivity() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/health'),
        headers: ApiConfig.defaultHeaders,
      ).timeout(const Duration(seconds: 5));
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(defaultValue: 0)
  final int id;

  // Permettre les valeurs null et fournir des valeurs par défaut
  @JsonKey(defaultValue: '')
  final String nom;

  @JsonKey(defaultValue: '')
  final String prenom;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: '')
  final String telephone;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    this.createdAt,
    this.updatedAt,
  });

  // Factory avec gestion d'erreur personnalisée
  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserFromJson(json);
    } catch (e) {
      print('❌ Erreur dans User.fromJson: $e');
      print('JSON reçu: $json');

      // Créer un utilisateur par défaut en cas d'erreur
      return User(
        id: json['id'] ?? 0,
        nom: json['nom']?.toString() ?? '',
        prenom: json['prenom']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        telephone: json['telephone']?.toString() ?? '',
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString(),
      );
    }
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // Méthode pour obtenir le nom complet
  String get nomComplet => '$prenom $nom';

  // Méthode toString pour le debug
  @override
  String toString() {
    return 'User{id: $id, nom: $nom, prenom: $prenom, email: $email, telephone: $telephone}';
  }
}

@JsonSerializable()
class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$AuthResponseFromJson(json);
    } catch (e) {
      print('❌ Erreur dans AuthResponse.fromJson: $e');
      print('JSON reçu: $json');

      // Essayer de créer manuellement en cas d'erreur
      return AuthResponse(
        token: json['token']?.toString() ?? '',
        user: User.fromJson(json['user'] ?? json['utilisateur'] ?? {}),
      );
    }
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class ApiError {
  final String message;
  final Map<String, List<String>>? errors;

  ApiError({required this.message, this.errors});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    try {
      return _$ApiErrorFromJson(json);
    } catch (e) {
      print('❌ Erreur dans ApiError.fromJson: $e');
      return ApiError(
        message: json['message']?.toString() ?? 'Erreur inconnue',
      );
    }
  }

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

// Classe pour gérer la réponse complète de Laravel
@JsonSerializable()
class LaravelApiResponse {
  final bool success;
  final String message;
  final LaravelAuthData? data;
  final Map<String, dynamic>? errors;

  LaravelApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory LaravelApiResponse.fromJson(Map<String, dynamic> json) =>
      _$LaravelApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LaravelApiResponseToJson(this);
}

@JsonSerializable()
class LaravelAuthData {
  final User utilisateur;
  final String token;

  @JsonKey(name: 'token_type', defaultValue: 'Bearer')
  final String tokenType;

  LaravelAuthData({
    required this.utilisateur,
    required this.token,
    required this.tokenType,
  });

  factory LaravelAuthData.fromJson(Map<String, dynamic> json) =>
      _$LaravelAuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$LaravelAuthDataToJson(this);
}

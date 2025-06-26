// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String? ?? '',
  prenom: json['prenom'] as String? ?? '',
  email: json['email'] as String? ?? '',
  telephone: json['telephone'] as String? ?? '',
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'prenom': instance.prenom,
  'email': instance.email,
  'telephone': instance.telephone,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  token: json['token'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
  message: json['message'] as String,
  errors: (json['errors'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'message': instance.message,
  'errors': instance.errors,
};

LaravelApiResponse _$LaravelApiResponseFromJson(Map<String, dynamic> json) =>
    LaravelApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : LaravelAuthData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LaravelApiResponseToJson(LaravelApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
    };

LaravelAuthData _$LaravelAuthDataFromJson(Map<String, dynamic> json) =>
    LaravelAuthData(
      utilisateur: User.fromJson(json['utilisateur'] as Map<String, dynamic>),
      token: json['token'] as String,
      tokenType: json['token_type'] as String? ?? 'Bearer',
    );

Map<String, dynamic> _$LaravelAuthDataToJson(LaravelAuthData instance) =>
    <String, dynamic>{
      'utilisateur': instance.utilisateur,
      'token': instance.token,
      'token_type': instance.tokenType,
    };

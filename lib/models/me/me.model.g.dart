// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Me _$MeFromJson(Map<String, dynamic> json) => Me(
      json['id'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['username'] as String,
      json['email'] as String,
      ProfilePicture.fromJson(json['profilePicture'] as Map<String, dynamic>),
      UserFamily.fromJson(json['family'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeToJson(Me instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'family': instance.family,
    };

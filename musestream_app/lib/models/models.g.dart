// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      type: json['type'] as String,
      pictureUrl: json['pictureUrl'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'type': instance.type,
      'pictureUrl': instance.pictureUrl,
      'id': instance.id,
    };

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      title: json['title'] as String,
      description: json['description'] as String,
      instrument: json['instrument'] as String,
      id: json['id'] as int?,
      teacherId: json['teacherId'] as int?,
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'instrument': instance.instrument,
      'id': instance.id,
      'teacherId': instance.teacherId,
    };

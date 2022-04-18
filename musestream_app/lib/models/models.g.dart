// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      json['token'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      type: json['type'] as String,
      id: json['id'] as int,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'type': instance.type,
      'fullName': instance.fullName,
    };

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      title: json['title'] as String,
      description: json['description'] as String,
      instrument: json['instrument'] as String,
      id: json['id'] as int?,
      teacherId: json['teacherId'] as int?,
      teacher: json['teacher'] == null
          ? null
          : User.fromJson(json['teacher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'instrument': instance.instrument,
      'id': instance.id,
      'teacherId': instance.teacherId,
      'teacher': instance.teacher,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      classStudentId: json['classStudentId'] as int,
      notes: json['notes'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      videoConnection: json['videoConnection'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'classStudentId': instance.classStudentId,
      'notes': instance.notes,
      'start': instance.start,
      'end': instance.end,
      'videoConnection': instance.videoConnection,
    };

RequestClass _$RequestClassFromJson(Map<String, dynamic> json) => RequestClass(
      classId: json['classId'] as int,
      studentId: json['studentId'] as int,
      date: json['date'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RequestClassToJson(RequestClass instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'studentId': instance.studentId,
      'date': instance.date,
      'message': instance.message,
    };

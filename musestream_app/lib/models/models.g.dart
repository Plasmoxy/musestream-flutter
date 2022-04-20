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
      id: json['id'] as int,
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
      id: json['id'] as int,
      classStudentId: json['classStudentId'] as int,
      notes: json['notes'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      roomId: json['roomId'] as String?,
      classStudent: json['classStudent'] == null
          ? null
          : ClassStudent.fromJson(json['classStudent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'classStudentId': instance.classStudentId,
      'notes': instance.notes,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'roomId': instance.roomId,
      'classStudent': instance.classStudent,
    };

ClassStudent _$ClassStudentFromJson(Map<String, dynamic> json) => ClassStudent(
      id: json['id'] as int,
      classId: json['classId'] as int,
      studentId: json['studentId'] as int,
      student: json['student'] == null
          ? null
          : User.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassStudentToJson(ClassStudent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'studentId': instance.studentId,
      'student': instance.student,
    };

ClassRequest _$ClassRequestFromJson(Map<String, dynamic> json) => ClassRequest(
      id: json['id'] as int,
      classId: json['classId'] as int,
      studentId: json['studentId'] as int,
      date: json['date'] as String,
      message: json['message'] as String,
      classObj: json['class'] == null
          ? null
          : Class.fromJson(json['class'] as Map<String, dynamic>),
      student: json['student'] == null
          ? null
          : User.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassRequestToJson(ClassRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'studentId': instance.studentId,
      'date': instance.date,
      'message': instance.message,
      'class': instance.classObj,
      'student': instance.student,
    };

ClassFile _$ClassFileFromJson(Map<String, dynamic> json) => ClassFile(
      id: json['id'] as int,
      classId: json['classId'] as int,
      title: json['title'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$ClassFileToJson(ClassFile instance) => <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'title': instance.title,
      'path': instance.path,
    };

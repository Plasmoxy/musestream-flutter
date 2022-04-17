import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class TokenData {
  final String token;
  final User user;

  TokenData(this.token, this.user);

  factory TokenData.fromJson(Map<String, dynamic> json) => _$TokenDataFromJson(json);
  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final String type;

  User({required this.name, required this.email, required this.type, required this.id});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

final MOCK_USER = User(id: 0, email: 'mail@mail', name: 'Mock', type: 'student');

@JsonSerializable()
class Class {
  final String title;
  final String description;
  final String instrument;
  final int? id;
  final int? teacherId;
  final User? teacher;

  Class({required this.title, required this.description, required this.instrument, this.id, this.teacherId, this.teacher});

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}

@JsonSerializable()
class Lesson {
  final int classStudentId;
  final String notes;
  final String start;
  final String end;
  final String videoConnection;

  Lesson({required this.classStudentId, required this.notes, required this.start, required this.end, required this.videoConnection});

  // TODO jsonn
}

@JsonSerializable()
class RequestClass {
  final int classId;
  final int studentId;
  final String date;
  final String message;

  RequestClass({
    required this.classId,
    required this.studentId,
    required this.date,
    required this.message,
  });

  // TODO jsonn
}

final MOCK_CLASS = Class(id: 0, instrument: 'Nervy', description: 'Hra na nervy', title: 'MTAA', teacher: MOCK_USER, teacherId: 0);

final MOCK_LESSON = Lesson(classStudentId: 0, notes: 'This is a lesson', start: '15.05.2022', end: '16.05.2022', videoConnection: 'working');

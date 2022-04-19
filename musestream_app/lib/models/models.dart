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
  final String fullName;

  User({required this.name, required this.email, required this.type, required this.id, required this.fullName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Class {
  final String title;
  final String description;
  final String instrument;
  final int id;
  final int? teacherId;
  final User? teacher;

  Class({required this.title, required this.description, required this.instrument, required this.id, this.teacherId, this.teacher});

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}

@JsonSerializable()
class Lesson {
  final int id;
  final int classStudentId;
  final String notes;
  final DateTime start;
  final DateTime end;
  final String? roomId;

  final ClassStudent? classStudent;

  Lesson({required this.id, required this.classStudentId, required this.notes, required this.start, required this.end, this.roomId, this.classStudent});

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable()
class ClassStudent {
  final int id;
  final int classId;
  final int studentId;
  final User? student;

  ClassStudent({
    required this.id,
    required this.classId,
    required this.studentId,
    this.student,
  });

  factory ClassStudent.fromJson(Map<String, dynamic> json) => _$ClassStudentFromJson(json);
  Map<String, dynamic> toJson() => _$ClassStudentToJson(this);
}

@JsonSerializable()
class ClassRequest {
  final int id;
  final int classId;
  final int studentId;
  final String date;
  final String message;

  @JsonKey(name: 'class')
  final Class? classObj;

  final User? student;

  ClassRequest({required this.id, required this.classId, required this.studentId, required this.date, required this.message, this.classObj, this.student});

  factory ClassRequest.fromJson(Map<String, dynamic> json) => _$ClassRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ClassRequestToJson(this);
}

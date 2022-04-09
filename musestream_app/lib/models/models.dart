import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  final String type;
  final String pictureUrl;
  final int? id;

  User({required this.name, required this.email, required this.type, required this.pictureUrl, this.id});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

final MOCK_TEACHER = User(id: 0, email: 'mail@mail', name: 'Mock', pictureUrl: '', type: 'teacher');

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

final MOCK_CLASS = Class(id: 0, instrument: 'Nervy', description: 'Hra na nervy', title: 'MTAA', teacher: MOCK_TEACHER, teacherId: 0);

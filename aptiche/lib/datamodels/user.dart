import 'dart:convert';

class User {
  User(
      {required this.userId,
      required this.authId,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.rollNo,
      required this.quizList});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(dynamic json) => User(
        userId: json['userId'].toString(),
        authId: json['authId'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
        phoneNo: json['phoneNo'].toString(),
        rollNo: json['rollNo'].toString(),
        quizList: json['quizList'],
      );

  final String? userId;
  final String? authId;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? rollNo;
  final dynamic quizList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'docId': authId,
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'rollNo': rollNo,
        'quizList': quizList,
      };
}

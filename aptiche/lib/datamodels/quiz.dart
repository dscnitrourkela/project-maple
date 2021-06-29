import 'dart:convert';

class Quiz {
  Quiz(
      {required this.quizId,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.questions,
      required this.instructions,
      required this.description,
      required this.submissions,
      required this.active});

  factory Quiz.fromJson(String str) => Quiz.fromMap(json.decode(str));

  factory Quiz.fromMap(dynamic json) => Quiz(
      quizId: json['quizId'].toString(),
      name: json['name'].toString(),
      startTime: json['startTime'],
      endTime: json['endTime'],
      questions: json['questions'],
      instructions: json['instructions'],
      description: json['description'].toString(),
      submissions: json['submission'],
      active: json['active']);

  final String? quizId;
  final String? name;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic questions; // string - questionId
  final dynamic instructions;
  final String description;
  final dynamic submissions; // string - userId, int - score
  final dynamic active;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'quizId': quizId,
        'name': name,
        'startTime': startTime,
        'endTime': endTime,
        'questions': questions,
        'instructions': instructions,
        'description': description,
        'submission': submissions,
        'active': active
      };
}

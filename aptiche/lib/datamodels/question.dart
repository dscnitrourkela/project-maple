import 'dart:convert';

class Question {
  Question({
    required this.questionId,
    required this.question,
    required this.url,
    required this.options,
    required this.answer,
    required this.positiveMark,
    required this.negativeMark,
    required this.explanation,
  });

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));
  factory Question.fromMap(dynamic json) => Question(
        questionId: json['questionId'].toString(),
        question: json['question'].toString(),
        url: json['url'].toString(),
        options: json['options'],
        answer: json['answer'].toString(),
        positiveMark: json['positiveMark'],
        negativeMark: json['negativeMark'],
        explanation: json['explanation'].toString(),
      );

  String questionId;
  String question;
  String url;
  dynamic options;
  String answer;
  dynamic positiveMark;
  dynamic negativeMark;
  String explanation;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'questionId': questionId,
        'question': question,
        'url': url,
        'options': options,
        'answer': answer,
        'positiveMark': positiveMark,
        'negativeMark': negativeMark,
        'explanation': explanation,
        
      };
}

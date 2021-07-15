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

  String questionId;
  String question;
  String url;
  dynamic options;
  String answer;
  dynamic positiveMark;
  dynamic negativeMark;
  String explanation;
}

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

  final String? quizId;
  final String? name;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic questions; // string - questionId
  final dynamic instructions;
  final String description;
  final dynamic submissions; // string - userId, int - score
  final dynamic active;
}

class User {
  User(
      {required this.userId,
      required this.authId,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.rollNo,
      required this.quizList});

  final String? userId;
  final String? authId;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? rollNo;
  final dynamic quizList;
}

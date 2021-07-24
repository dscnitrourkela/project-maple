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
      // required this.questions,
      // required this.instructions,
      // required this.description,
      // required this.submissions,
      required this.active});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['_id'] as String,
      name: json['name'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      // questions: json['questions'] as List<Question>,
      // instructions: json['instructions'] as List<String>,
      active: json['active'] as bool,
    );
  }

  final String? quizId;
  final String? name;
  String startTime;
  String endTime;
  // final List<Question> questions; // string - questionId
  // final List<String> instructions;
  // final String description;
  // final dynamic submissions; // string - userId, int - score
  final bool active;
}

class UserInput {
  UserInput({
    required this.fcmTokens,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.rollNo,
  });

  final String? fcmTokens;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? rollNo;
}

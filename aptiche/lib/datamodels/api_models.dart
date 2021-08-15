class Question {
  Question({
    required this.questionId,
    required this.question,
    // required this.url,
    required this.options,
    required this.answer,
    required this.positiveMark,
    required this.negativeMark,
    required this.explanation,
    this.choice,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['_id'] as String,
      question: json['question'] as String,
      options: json['options'] as List<String>,
      answer: json['answer'] as String,
      positiveMark: json['positiveMark'] as int,
      negativeMark: json['negativeMark'] as int,
      explanation: json['explanation'] as String,
    );
  }

  String questionId;
  String question;
  // String url;
  List<String> options;
  String answer;
  int positiveMark;
  int negativeMark;
  String explanation;
  String? choice;
}

class Quiz {
  Quiz(
      {required this.quizId,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.questionIds,
      required this.instructions,
      // required this.description,
      // required this.submissions,
      required this.active});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['_id'] as String,
      name: json['name'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      questionIds: json['questionsIds'] as List<String?>?,
      instructions: json['instructions'] as List<String>,
      active: json['active'] as bool,
    );
  }

  final String? quizId;
  final String? name;
  String startTime;
  String endTime;
  final List<String?>? questionIds; // string - questionId
  final List<String> instructions;
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

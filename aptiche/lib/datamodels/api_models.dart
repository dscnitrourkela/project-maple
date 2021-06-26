import 'package:aptiche/datamodels/quiz.dart';

class PastQuizzes {
  PastQuizzes({
    this.pastList,
  });
  final List<Quiz>? pastList;
}

class FutureQuizzes {
  FutureQuizzes({
    this.futureList,
  });
  final List<Quiz>? futureList;
}

class LiveQuiz {
  LiveQuiz({
    this.liveQuiz,
  });
  final Quiz? liveQuiz;
}


import 'package:aptiche/datamodels/quiz.dart';

abstract class Api {
  Future<List<Quiz>> getPastQuiz();

  Future<List<Quiz>> getFutureQuiz();

  Future<Quiz> getLiveQuiz();
}

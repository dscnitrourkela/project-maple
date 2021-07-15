import 'package:aptiche/datamodels/api_models.dart';

abstract class Api {
  Future<List<Quiz>> getPastQuiz();

  Future<List<Quiz>> getFutureQuiz();

  Future<Quiz> getLiveQuiz();
}

import 'package:aptiche/datamodels/question.dart';
import 'package:aptiche/datamodels/quiz.dart';

import 'api.dart';

class FakeApi extends Api {
  final Question sample = Question(
      questionId: '001',
      question: 'GDSC stands for what?',
      url:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.oberlo.com%2Fblog%2Fimage-search-engine&psig=AOvVaw0L2yDNv9BvLZI6DaAcF0-S&ust=1624821783127000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCKi9jf2CtvECFQAAAAAdAAAAABAD',
      options: <String>[
        'Google Developers Students Club',
        'Google Developers Simps Club',
        'Google Discord Student Community',
        'None of the above',
      ],
      answer: 'Google Developers Student Community',
      positiveMark: 3,
      negativeMark: -1,
      explanation: 'It is what it is');
  final List<String> sampleInstruction = <String>[];
  final String sampleDescription =
      'This is a sample description, which is supposed to be pretty loooooooooooooooooooongggggggggg.';

  @override
  Future<List<Quiz>> getFutureQuiz() {
    final Quiz futureSampleQuiz = Quiz(
      name: 'future fake',
      quizId: '1234567',
      description: sampleDescription,
      startTime: DateTime(2022, 01, 01, 05, 05, 00),
      endTime: DateTime(2022, 01, 01, 06, 05, 00),
      questions: <Question>[
        sample,
        sample,
        sample,
        sample,
        sample,
      ],
      instructions: sampleInstruction,
      active: false,
      submissions: <dynamic>[],
    );

    final List<Quiz> futureList =
        List<Quiz>.generate(10, (int index) => futureSampleQuiz);

    return Future<List<Quiz>>.value(futureList);
  }

  @override
  Future<Quiz> getLiveQuiz() {
    final Quiz liveSampleQuiz = Quiz(
      quizId: 'asdfgh',
      name: 'live fake',
      startTime: DateTime(2021, 06, 30, 05, 05, 00),
      endTime: DateTime(2021, 06, 30, 06, 05, 00),
      questions: sample,
      instructions: sampleInstruction,
      description: sampleDescription,
      submissions: <dynamic>[],
      active: true,
    );
    return Future<Quiz>.value(liveSampleQuiz);
  }

  @override
  Future<List<Quiz>> getPastQuiz() {
    final Quiz pastSampleQuiz = Quiz(
      name: 'past fake',
      quizId: '123567',
      description: sampleDescription,
      startTime: DateTime(2020, 01, 01, 05, 05, 00),
      endTime: DateTime(2020, 01, 01, 06, 05, 00),
      questions: <Question>[
        sample,
        sample,
        sample,
        sample,
        sample,
      ],
      instructions: sampleInstruction,
      active: false,
      submissions: <dynamic>[],
    );

    final List<Quiz> pastList =
        List<Quiz>.generate(10, (int index) => pastSampleQuiz);

    return Future<List<Quiz>>.value(pastList);
  }
}

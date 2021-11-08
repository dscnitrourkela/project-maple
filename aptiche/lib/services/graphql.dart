import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/net/remote_config.dart';
import 'package:aptiche/utils/mutation.dart';
import 'package:aptiche/utils/query.dart';
import 'package:aptiche/views/splashscreen/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final RemoteConfigService _remoteConfigService = Get.find();
  final UserController _userController = Get.find();

  /// Stores the [GraphQLClient]
  late GraphQLClient _client;

  /// Intialises the [GraphQLClient]
  Future<void> initGraphQL(String token) async {
    /// Initialise Remote Config.
    await _remoteConfigService.setupRemoteConfig();

    /// Get the apiUrl and apiKey from remote config.
    final HttpLink _httpLink = HttpLink(
      '${_remoteConfigService.apiUrl}?apikey=${_remoteConfigService.apiKey}',
    );

    final AuthLink _authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link _link = _authLink.concat(_httpLink);
    _client = GraphQLClient(link: _link, cache: GraphQLCache());

    debugPrint('GraphQL initialised');
  }

  Future<void> getUser() async {
    final QueryOptions options = QueryOptions(
        document: gql(getUsers),
        variables: <String, List<String>>{'ids': <String>[]},
        pollInterval: const Duration(seconds: 10));

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }
  }

  ///A graphql query that checks whether a user is pre-existing in the database
  Future<String?> checkUserbyPhone(String phoneNo) async {
    final QueryOptions options = QueryOptions(
      document: gql(getUserbyPhone),
      variables: <String, String>{'phone': phoneNo},
    );

    try {
      final QueryResult result = await _client.query(options);

      if (result.hasException) {
        return Future<String?>.value('null');
      } else {
        final Map<String, dynamic>? user = result.data;
        final String userId = user!['getUserByPhone']['_id'].toString();
        _userController.name.value = user['getUserByPhone']['name'].toString();
        return userId;
      }
    } catch (e) {
      rethrow;
    }
  }

  ///A  graphql query that fetches the data of the user for profile page
  Future<Map<String, String?>?> getUserDatabyPhone({String? phoneNo}) async {
    final QueryOptions options = QueryOptions(
      document: gql(getUserbyPhone),
      variables: <String, String?>{'phone': phoneNo},
    );

    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
        debugPrint(result.exception.toString());
      } else {
        final Map<String, String?> dataMap = <String, String?>{
          'name': '',
          'phone': '',
          'email': '',
          'rollNo': '',
        };
        final Map<String, dynamic>? user = result.data;
        dataMap['name'] = user!['getUserByPhone']['name'].toString();
        dataMap['phone'] = user['getUserByPhone']['phoneNo'].toString();
        dataMap['email'] = user['getUserByPhone']['email'].toString();
        dataMap['rollNo'] = user['getUserByPhone']['rollNo'].toString();
        return dataMap;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// A graphql mutation that creates a user and stores the data in the
  /// database.
  Future<String?> createUsers({
    List<String?>? fcmTokens,
    String? name,
    String? email,
    String? phoneNo,
    String? rollNo,
    List<String?>? quizzes,
  }) async {
    final QueryResult result = await _client.mutate(
      MutationOptions(document: gql(createUser), variables: <String, dynamic>{
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'rollNo': rollNo,
        'fcmToken': fcmTokens,
        'quizzes': quizzes
      }),
    );
    if (result.hasException) {
      debugPrint(result.exception.toString());
    }
    debugPrint(result.toString());
    return result.data!['createUser']['_id'].toString();
  }

  /// Takes any integer between 1-3 and queries the [GraphQL] server to get
  /// quizzes according the integer passed.
  /// `1 - Past Quizzes`
  /// `2 - Active Quizzes`
  /// `3 - Upcoming Quizzes`
  Future<List<Quiz>> getQuizzesByTime(int integer) async {
    final QueryOptions options = QueryOptions(
      document: gql(getQuizzesByTimeQuery),
      variables: <String, int>{'int': integer},
    );
    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
        debugPrint(result.exception.toString());
      }

      /// Takes in data from [QueryResult] and converts it to a map
      List<Map<String, dynamic>>? toMap(Map<String, dynamic> data) {
        /// Stores the list of instruction strings.

        final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
        // Since graphql is returning everything as an object, each string in
        // the instructions list is first converted from an object to string
        // and then parsed into the map.
        for (final dynamic quiz in data['getQuizzesByTime']) {
          final List<String> questionIdsList = <String>[];
          final List<String> instructionsList = <String>[];
          for (final dynamic instruction in quiz['instructions']) {
            instructionsList.add(instruction.toString());
          }

          for (final dynamic questionId in quiz['questionIds']) {
            questionIdsList.add(questionId.toString());
          }

          final Map<String, dynamic> listItem = <String, dynamic>{
            '_id': quiz['_id'],
            'name': quiz['name'],
            'startTime': quiz['startTime'],
            'endTime': quiz['endTime'],
            'instructions': instructionsList,
            'questionIds': questionIdsList,
            'active': quiz['active']
          };

          list.add(listItem);
        }

        return list;
      }

      final List<Map<String, dynamic>>? getQuizzes = toMap(result.data!);

      /// Stores the final result i.e. all the quizzes.
      final List<Quiz> quizzes = <Quiz>[];

      /// Converts the map into a [Quiz] Object
      for (final Map<String, dynamic> quiz in getQuizzes!) {
        final Quiz singleQuiz = Quiz.fromJson(quiz);
        quizzes.add(singleQuiz);
      }
      return quizzes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Question>> getQuestionsByQuiz(List<String> ids) async {
    final QueryOptions options = QueryOptions(
        document: gql(getQuestionsByQuizQuery),
        variables: <String, List<String>>{'ids': ids});
    try {
      final QueryResult result = await _client.query(options);

      if (result.hasException) {
        debugPrint(result.exception.toString());
      }

      /// Takes in data from [QueryResult] and converts it to a map
      List<Map<String, dynamic>> toMap(Map<String, dynamic> data) {
        /// Stores the list of instruction strings.

        final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
        // Since graphql is returning everything as an object, each string in
        // the instructions list is first converted from an object to string
        // and then parsed into the map.
        for (final dynamic quiz in data['getQuestionsForQuiz']) {
          for (final dynamic question in quiz) {
            /// Stores the parsed option from the data['options'].
            final List<String> options = <String>[];
            // The list is emptied so that everytime the loop is run,
            // the options of the current question won't get added to the
            //options of the previous questions.
            options.length = 0;

            for (final dynamic option in question['options']) {
              if (options.length < 4) {
                options.add(option.toString());
              }
            }

            final Map<String, dynamic> listItem = <String, dynamic>{
              '_id': question['_id'],
              'question': question['question'],
              'image': question['image'],
              'options': options,
              'answer': question['answer'],
              'positiveMark': question['positiveMark'],
              'negativeMark': question['negativeMark'],
              'explanation': question['explanation'],
            };
            list.add(listItem);
          }
        }
        return list;
      }

      final List<Map<String, dynamic>> getQuestionsByQuiz = toMap(result.data!);

      final List<Question> questions = <Question>[];

      for (final Map<String, dynamic> question in getQuestionsByQuiz) {
        final Question singleQuestion = Question.fromJson(question);
        questions.add(singleQuestion);
      }

      return questions;
    } catch (e) {
      rethrow;
    }
  }
}

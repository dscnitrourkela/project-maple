import 'package:aptiche/utils/query.dart';
import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  late GraphQLClient _client;

  Future<void> initGraphQL(String? token) async {
    final HttpLink _httpLink = HttpLink(Strings.GRAPHQL_URL);
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

  Future<List<Quiz>> getQuizzes() async {
    final QueryOptions options = QueryOptions(
      document: gql(getQuiz),
      variables: <String, List<String>>{'ids': <String>[]},
    );
    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
        debugPrint(result.exception.toString());
      }

      /// Takes in data from [QueryResult] and converts it to a map
      List<Map<String, dynamic>> toMap(Map<String, dynamic> data) {
        final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
        for (final dynamic quiz in data['getQuizzes']) {
          final Map<String, dynamic> listItem = <String, dynamic>{
            '_id': quiz['_id'],
            'name': quiz['name'],
            'startTime': quiz['startTime'],
            'endTime': quiz['endTime'],
            'instructions': quiz['instructions'],
            'active': quiz['active']
          };
          list.add(listItem);
        }
        return list;
      }

      final List<Map<String, dynamic>> getQuizzes = toMap(result.data!);

      final List<Quiz> quizzes = <Quiz>[];

      for (final Map<String, dynamic> quiz in getQuizzes) {
        final Quiz singleQuiz = Quiz.fromJson(quiz);
        quizzes.add(singleQuiz);
      }

      return quizzes;
    } catch (e) {
      rethrow;
    }
  }
}

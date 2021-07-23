import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/query.dart';
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

  Future<String?> createUsers(
    String? fcmTokens,
    String? name,
    String? email,
    String? phoneNo,
    String? rollNo,
    List<String?>? quizzes,
  ) async {
    final QueryResult result = await _client.query(
      QueryOptions(document: gql(createUser), variables: <String, dynamic>{
        'userInput': {
          'name': name,
          'email': email,
          'phoneNo': phoneNo,
          'fcmToken': fcmTokens,
          'rollNo': rollNo,
          'quizzes': quizzes
        }
      }),
    );
    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    return result.data.toString();
  }

  Future<void> getQuizzes() async {
    final QueryOptions options = QueryOptions(
      document: gql(getQuiz),
      variables: <String, dynamic>{'ids': <String>[]},
    );
    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
        debugPrint(result.exception.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}

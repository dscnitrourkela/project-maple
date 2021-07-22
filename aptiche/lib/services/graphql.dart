import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/query.dart';
import 'package:aptiche/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  late GraphQLClient client;

  Future<void> initGraphQL(String? token) async {
    final HttpLink _httpLink = HttpLink(Strings.GRAPHQL_URL);
    final AuthLink _authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link _link = _authLink.concat(_httpLink);
    client = GraphQLClient(link: _link, cache: GraphQLCache());
    debugPrint('GraphQL initialised');
  }

  Future<void> getUser() async {
    final QueryOptions options = QueryOptions(
        document: gql(getUsers),
        variables: <String, List<String>>{'ids': <String>[]},
        pollInterval: const Duration(seconds: 10));

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }
  }

  Future<String> createUsers(
    String? uId,
    String? fcmTokens,
    String? name,
    String? email,
    String? phoneNo,
    String? rollNo,
    List<String>? quizList,
  ) async {
    MutationOptions(
        document: gql(createUser),
        onCompleted: (dynamic resultData) {
          return resultData.toString();
        },
        update: (GraphQLDataProxy cache, QueryResult? result) {},
        onError: (OperationException? error) {
          debugPrint(error!.graphqlErrors.toString());
        },
        variables: <String, UserInput>{
          'input': UserInput(
              name: name,
              email: email,
              phoneNo: phoneNo,
              uId: uId,
              fcmTokens: fcmTokens,
              rollNo: rollNo,
              quizList: quizList)
        });

    return 'fetching error';
  }

  Future<void> getQuizzes() async {
    final QueryOptions options = QueryOptions(
      document: gql(getQuiz),
      variables: <String, dynamic>{'ids': <String>[]},
    );
    try {
      final QueryResult result = await client.query(options);
      if (result.hasException) {
        debugPrint(result.exception.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}

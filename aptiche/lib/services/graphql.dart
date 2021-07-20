import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/query.dart';
import 'package:aptiche/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  late GraphQLClient client;

  Future<void> initGraphQL() async {
    final String token = await AuthService().getUserToken();
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

  Future<String> createUsers() async {
    final MutationOptions options = MutationOptions(
      document: gql(createUser),
      update: (GraphQLDataProxy cache, QueryResult result) {
        return cache;
      },
      // or do something with the result.data on completion
      onCompleted: (dynamic resultData) {
        print(resultData);
      },
      //variables: <String,UserInput>{'input': UserInput()}
    );

    ;
  }

  /* Future<void> getQuizzes() async {
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
  } */
}

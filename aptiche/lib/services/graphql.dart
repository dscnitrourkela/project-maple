import 'dart:convert';
import 'dart:io' show stdout, stderr, exit;
import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/string.dart';
import 'package:graphql/client.dart';

class GraphQL {
  late GraphQLClient _client;

  Future<void> initGraphQL() async {
    final String token = await AuthService().getUserToken();

    final HttpLink _httpLink = HttpLink(Strings.GRAPHQL_URL);

    final AuthLink _authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link _link = _authLink.concat(_httpLink);

    _client = GraphQLClient(link: _link, cache: GraphQLCache());

    print('GraphQL initialised');
  }

  // Queries

  Future<void> getUser() async {
    const String query = r'''
      query getUsers($ids: [ObjectId!]!){
        getUsers(ids: $ids) {
            name
            email
            rollNo
            _id
            uid
            fcmToken
            name
          }
        }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: <String, List<String>>{'ids': []},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception);
    }

    print('result: ${result.data}');
  }

  Future<void> getQuizzes() async {
    const String query = r'''
      query getQuizzes($ids: [ObjectId!]!){
        getQuizzes(ids: $ids){
          _id
        }
      }
    ''';
    print('started');
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: <String, dynamic>{'ids': <String>[]},
    );
    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
        stderr.writeln(result.exception.toString());
      }
      print('stopped');
      print(result.data);
    } catch (e) {
      rethrow;
    }

    // final List<Quiz> quizzes = result.data! as List<Quiz>;

    // print(quizzes);

    // List<Quiz> quizzes =
    //     result.data!.map<Quiz>((Quiz json) => Quiz.fromJson(json)).toList();

    // return quizzes;
  }
}

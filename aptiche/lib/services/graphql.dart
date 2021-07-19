<<<<<<< HEAD
import 'package:aptiche/utils/query.dart';
=======
import 'dart:convert';

import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/net/authservice.dart';
>>>>>>> b6c3b76 (Fixes bugs with getQuizzes query)
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
<<<<<<< HEAD
=======
    const String query = r'''
      query getUsers($ids: [ObjectId!]!){
        getUsers(ids: $ids) {
            name
            email
            rollNo
            _id
            uid
            fcmToken
          }
        }
    ''';
>>>>>>> b6c3b76 (Fixes bugs with getQuizzes query)
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

  Future<void> getQuizzes() async {
<<<<<<< HEAD
    final QueryOptions options = QueryOptions(
      document: gql(getQuiz),
      variables: <String, dynamic>{'ids': <String>[]},
=======
    const String query = r'''
      query getQuizzes($ids: [ObjectId!]!){
        getQuizzes(ids: $ids){
          _id,
          name,
          startTime,
          endTime,
        }
      }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: <String, List<String>>{'ids': []},
>>>>>>> b6c3b76 (Fixes bugs with getQuizzes query)
    );
    try {
      final QueryResult result = await _client.query(options);
      if (result.hasException) {
<<<<<<< HEAD
        debugPrint(result.exception.toString());
      }
=======
        print(result.exception);
      }

      // print(result.data);

      List<Object?> quizzes = result.data!['getQuizzes'] as List<Object?>;

      // quizzes.forEach(Object (element) {
      //   Quiz.fromJson(element);
      // });

      // quizzes.map<Quiz>((json) => Quiz.fromJson(json)).toList();

      // final List<Quiz> quizzes = result.data! as List<Quiz>;

      print(quizzes);

      // return quizzes;
>>>>>>> b6c3b76 (Fixes bugs with getQuizzes query)
    } catch (e) {
      rethrow;
    }
  }
}

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
  }

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
        document: gql(query), variables: <String, List<String>>{'ids': []});

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception);
    }

    print('result: ${result.data}');
  }
}

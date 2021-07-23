const String getUsers = r'''
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

const String createUser = r'''
mutation createUser($userInput: UserInput!) {
  createUser(userDetails: $userInput) {
      _id
  }
}
''';

const String getQuiz = r'''
      query getQuizzes($ids: [ObjectId!]!){
        getQuizzes(ids: $ids){
          _id
          name
        }
      }
    ''';

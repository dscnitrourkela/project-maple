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
mutation createUser(
  $name: String!
  $email: String!
  $phoneNo: String!
  $rollNo: String!
  $fcmToken: [String!]!
  $quizzes: [ObjectId!]!
) {
  createUser(
    userDetails: {
      name: $name
      email: $email
      phoneNo: $phoneNo
      rollNo: $rollNo
      fcmToken: $fcmToken
      quizzes: $quizzes
    }
  ) {
    _id
  }
}
''';

const String getQuiz = r'''
      query getQuizzes($ids: [ObjectId!]!){
        getQuizzes(ids: $ids){
          _id
          name
          startTime
          endTime
          instructions
          active
        }
      }
    ''';

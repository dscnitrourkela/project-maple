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

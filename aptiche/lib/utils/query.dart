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

const String getUserbyPhone = r'''
      query getUserByPhone($phone: String!) {
        getUserByPhone(phoneNo: $phone) {
          _id 
          name
          rollNo
          email
          phoneNo
        }
      }
''';

const String getUserDatabyPhoneNo = r'''
      query getUserByPhone($phone: String!) {
        getUserByPhone(phoneNo: $phone) {
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
          questionIds
          instructions
          active
        }
      }
    ''';

const String getQuizzesByTimeQuery = r'''
        query getQuizByTime($int: Int!) {
          getQuizzesByTime(int: $int) {
            _id
            name
            startTime
            questionIds
            endTime
            instructions
            active
          }
        }
        ''';

const String getQuestionsByQuizQuery = r'''
        query getQuestionByQuiz($ids: [ObjectId!]!){
          getQuestionsForQuiz(ids: $ids){
            _id
            question
            image
            options
            answer
            positiveMark
            negativeMark
            explanation
          }
        }
        ''';

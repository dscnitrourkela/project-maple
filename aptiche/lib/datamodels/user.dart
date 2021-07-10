class UserObject {
  UserObject(
      {required this.authId,
      required this.name,
      required this.fcmToken,
      required this.email,
      required this.phoneNo,
      required this.rollNo,
      required this.quizList});

  final String? authId;
  final String? fcmToken;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? rollNo;
  final List<String>? quizList;
}

void setFCMToken(String fcmToken) {
  // change the FCM Token whenever necessary
}

void setNewUser(UserObject user) {
  //setting up the new User
}

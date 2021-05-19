class Validator {
  static String? validateName(String value) {
    const String pattern = r'(?=.*?[A-Za-z]).+';
    final RegExp regex = RegExp(
      pattern,
      multiLine: false,
    );
    if (value.isEmpty) {
      return 'Name must not be left blank.';
    }
    if (!regex.hasMatch(value)) {
      return "Invalid Name";
    }
    return null;
  }

  static String? validateEmail(String value) {
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      multiLine: false,
    );
    if (!regExp.hasMatch(value)) {
      return 'E-mail Address must be a valid Email Address.';
    }

    return null;
  }

  static String? validateRoll(String value) {
    RegExp regExp = new RegExp(
      r'([0-9])+[a-zA-Z]+[0-9]',
      multiLine: false,
    );
    if (!regExp.hasMatch(value)) {
      return "Roll Number must be a valid NIT Rourkela Roll Number";
    }
    return null;
  }

  static String? validatePhoneNo(String value) {
    RegExp regExp = new RegExp(
      r'^\+[1-9]{1}[0-9]{3,14}$',
      multiLine: false,
    );
    if (!regExp.hasMatch(value)) {
      return "Mobile Number must be valid";
    }
    return null;
  }
}

class ValidationMixin {
  String validateEmail(String value) {
    //return null if valid or string with the error message
    return value.contains("@") ? null : "Please enter a valid email";
  }

  String validatePassword(String value) {
    return value.length >= 4 ? null : "Pasword must be at least 4 characters";
  }
}

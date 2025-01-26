class InputValidator {
  static isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static isValidPassword(String? password) {
    if (password == null) {
      return 'Please enter your password';
    }
    if (password.length < 6) {
      return 'Password too short';
    }
    return null;
  }
}

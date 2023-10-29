class TText {
  // Global Text
  static const String appName = 'FlutterChat';
  // Auth Screen Text
  static const String emailHintText = 'Enter your email';
  static const String emailLabelText = 'Email Address';
  static const String passwordHintText = 'Enter your password';
  static const String passwordLabelText = 'Password';
  // Validation Error Text
  static String? getEmailValidatorText(String? email) {
    if (email!.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password Validation Error Text
  static String? getPasswordValidatorText(String? password) {
    if (password!.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one numeral';
    } else {
      return null;
    }
  }
}

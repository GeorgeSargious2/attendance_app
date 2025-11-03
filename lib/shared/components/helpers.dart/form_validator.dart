import 'package:flutter/material.dart';

String? validateName(String? value, context) {
  // String pattern = r'(^[a-zA-Z ]*$)';
  // RegExp regExp = RegExp(pattern);
  if (value?.trim().isEmpty ?? true) {
    return "Please enter your name";
  } else if (value!.trim().length < 3
      // !regExp.hasMatch(value ?? '')
      ) {
    return "Name must be more 3 characters";
  }
  return null;
}

String? validatePhone(String? value, context) {
  RegExp phoneRegex = RegExp(r'^\+2\d{11}$');
  if (value?.trim().isEmpty == true) {
    return "Please enter your phone number";
  } else if (phoneRegex.hasMatch(value ?? '')) {
    return "Mobile number must only contain digits";
    // } else if (!value!.trim().startsWith('+20') || value.trim().length != 12) {
    //   return "Please enter valid phone number";
  }
  return null;
}

String? validateRegisterPassword(String? value, context) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a valid password';
  }

  final String password = value.trim();

  const int minLength = 8;
  final bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  final bool hasDigits =
      RegExp(r'\d').hasMatch(password); // \d matches any digit [0-9]
  const String specialCharsPattern = r'@$!%*?&';
  final bool hasSpecialChars =
      RegExp('[$specialCharsPattern]').hasMatch(password);

  if (password.length < minLength) {
    return 'Password must be at least ' + '$minLength' + 'characters long';
  }

  if (!hasUppercase) {
    return 'Password must contain at least 1 uppercase letter';
  }

  if (!hasLowercase) {
    return 'Password must contain at least 1 lowercase letter';
  }

  if (!hasDigits) {
    return 'Password must contain at least 1 digit';
  }

  if (!hasSpecialChars) {
    return 'Password must contain at least 1 special character' +
        '$specialCharsPattern).';
  }

  return null;
}

String? validateLoginPassword(String? value, context) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a valid password';
  }
  // final passwordRegex = RegExp(
  //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  // if (!passwordRegex.hasMatch(value.trim())) {
  //   return 'Make password match the following conditions';
  // }
  return null;
}

bool isPasswordValid(String password) {
  return RegExp(
          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
      .hasMatch(password);
}

String? validateEmail(String? value, context) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Please enter valid email address';
  } else {
    return null;
  }
}

String? validateConfirmPassword(
    String? password, String? confirmPassword, context) {
  if (password != confirmPassword) {
    return 'Please confirm your password';
  } else if (confirmPassword?.isEmpty ?? true) {
    return 'The password ate not matching';
  } else {
    return null;
  }
}

String? validateOtp(String? value, {BuildContext? context}) {
  if (value == null || value.trim().isEmpty) {
    return context != null ? 'otpRequired' : 'OTP is required.';
  }
  if (value.trim().length != 6) {
    return context != null ? 'otpInvalidLength' : 'OTP must be 6 digits.';
  }
  if (int.tryParse(value.trim()) == null) {
    return context != null ? 'otpDigitsOnly' : 'OTP must contain only digits.';
  }
  return null;
}

String? validateNameOrEmail(String? value, context) {
  if (value == null || value.trim().isEmpty) {
    return 'namoemailreq';
  }
  return null;
}

bool hasLowerCase(String password) {
  return RegExp(r'^(?=.*[a-z])').hasMatch(password);
}

bool hasUpperCase(String password) {
  return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
}

bool hasNumber(String password) {
  return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
}

bool hasSpecialCharacter(String password) {
  return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
}

bool hasMinLength(String password) {
  return RegExp(r'^(?=.{8,})').hasMatch(password);
}

String? validateDescription(String? value, context) {
  if (value == null || value.trim().isEmpty) {
    return 'writedescr';
  }
  return null;
}

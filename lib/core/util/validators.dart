String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return "Email can't be empty";
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x 09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  return !regex.hasMatch(value) ? 'Enter a valid email address' : null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Please enter a password';
  if (value.length < 8 || value.length > 20) {
    return 'Password must be between 8 and 20 characters';
  }
  // const pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  // if (!RegExp(pattern).hasMatch(value)) {
  //   return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
  // }
  return null;
}

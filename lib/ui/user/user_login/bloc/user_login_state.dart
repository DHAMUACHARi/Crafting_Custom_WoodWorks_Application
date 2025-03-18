enum Status { data, processing, success, error }

class UserLoginState {
  final Status status;
  final String email;
  final String password;
  final String? emailValidationMsg;  // Nullable string
  final String? passwordValidationMsg;  // Nullable string
  final String? error;

  UserLoginState({
    required this.status,
    this.email = "",
    this.password = "",
    this.emailValidationMsg,
    this.passwordValidationMsg,
    this.error
  });

  UserLoginState copyWith({
    Status? status,
    String? email,
    String? password,
    String? emailValidationMsg,
    String? passwordValidationMsg,
    String? error,
  }) {
    return UserLoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      emailValidationMsg: emailValidationMsg ?? this.emailValidationMsg,
      passwordValidationMsg: passwordValidationMsg ?? this.passwordValidationMsg,
      error: error ?? this.error,
    );
  }
}

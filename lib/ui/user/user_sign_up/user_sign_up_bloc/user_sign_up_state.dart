enum Status { data, processing, success, failure }

class UserSignUpState {
  final int currentStep;
  final Status status;
  final String message;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String userType;
  final String dob;
  final String password;
  final String gender;

  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? phoneNumberError;
  final String? addressError;
  final String? userTypeError;
  final String? dobError;
  final String? passwordError;
  final String? genderError;

  const UserSignUpState({
    this.currentStep = 0,
    this.status = Status.data,
    this.message = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.userType = '',
    this.dob = '',
    this.password = '',
    this.gender = '',
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.phoneNumberError,
    this.addressError,
    this.userTypeError,
    this.dobError,
    this.passwordError,
    this.genderError,
  });

  UserSignUpState copyWith({
    int? currentStep,
    Status? status,
    String? message,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? userType,
    String? dob,
    String? password,
    String? gender,
    String? firstNameError,
    String? lastNameError,
    String? emailError,
    String? phoneNumberError,
    String? addressError,
    String? userTypeError,
    String? dobError,
    String? passwordError,
    String? genderError,
  }) {
    return UserSignUpState(
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      message: message ?? this.message,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      userType: userType ?? this.userType,
      dob: dob ?? this.dob,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      emailError: emailError,
      phoneNumberError: phoneNumberError,
      addressError: addressError,
      userTypeError: userTypeError,
      dobError: dobError,
      passwordError: passwordError,
      genderError: genderError,
    );
  }
}


abstract class UserSignUpEvent {}

final class UserSignUpName extends UserSignUpEvent {
  final String firstName;

  UserSignUpName(this.firstName);

  @override
  List<Object> get props => [firstName];
}

final class UserSignUpLastName extends UserSignUpEvent {
  final String lastName;

  UserSignUpLastName(this.lastName);

  @override
  List<Object> get props => [lastName];
}

final class UserSignUpEmail extends UserSignUpEvent {
  final String email;

  UserSignUpEmail(this.email);

  @override
  List<Object> get props => [email];
}

final class UserSignUpPhoneNumber extends UserSignUpEvent {
  final String phoneNumber;

  UserSignUpPhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

final class UserSignUpAddress extends UserSignUpEvent {
  final String address;

  UserSignUpAddress(this.address);

  @override
  List<Object> get props => [address];
}

final class UserSignUpUserType extends UserSignUpEvent {
  final String userType;

  UserSignUpUserType(this.userType);

  @override
  List<Object> get props => [userType];
}

final class UserSignUpDob extends UserSignUpEvent {
  final String dob;

  UserSignUpDob(this.dob);

  @override
  List<Object> get props => [dob];
}

final class UserSignUpPassword extends UserSignUpEvent {
  final String password;

  UserSignUpPassword(this.password);

  @override
  List<Object> get props => [password];
}

final class UserSignUpGender extends UserSignUpEvent {
  final String gender;

  UserSignUpGender(this.gender);

  @override
  List<Object> get props => [gender];
}
class UserSignUpNextStep extends UserSignUpEvent {}

class UserSignUpPreviousStep extends UserSignUpEvent {}
class UserSignUpValidateStep extends UserSignUpEvent {}
class UserSignUpFieldChanged extends UserSignUpEvent {}


final class UserSignUpSubmit extends UserSignUpEvent {}

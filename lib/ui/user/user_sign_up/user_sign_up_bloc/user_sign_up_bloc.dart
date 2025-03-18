import 'package:bloc/bloc.dart';
import 'package:crafting_custom_woodworks/models/user_model.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_event.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_state.dart';
import '../../../../Network/repository.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  final Repository repository;

  UserSignUpBloc({required this.repository}) : super(const UserSignUpState(status: Status.data)) {
    on<UserSignUpNextStep>(_onUserSignUpNextStep);
    on<UserSignUpPreviousStep>(_onUserSignUpPreviousStep);
    on<UserSignUpSubmit>(_onUserSignUpRequested);

    on<UserSignUpName>(_onUserSignUpName);
    on<UserSignUpLastName>(_onUserSignUpLastName);
    on<UserSignUpEmail>(_onUserSignUpEmail);
    on<UserSignUpPhoneNumber>(_onUserSignUpPhoneNumber);
    on<UserSignUpAddress>(_onUserSignUpAddress);
    // on<UserSignUpUserType>(_onUserSignUpUserType);
    on<UserSignUpDob>(_onUserSignUpDob);
    on<UserSignUpPassword>(_onUserSignUpPassword);
    on<UserSignUpGender>(_onUserSignUpGender);
  }

  void _onUserSignUpName(UserSignUpName event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpName - ${event.firstName}");
    final error = event.firstName.isNotEmpty ? null : "First name cannot be empty";
    emit(state.copyWith(firstName: event.firstName, firstNameError: error));
    print("Updated State: ${state.firstName}, Error: ${state.firstNameError}");
  }

  void _onUserSignUpLastName(UserSignUpLastName event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpLastName - ${event.lastName}");
    final error = event.lastName.isNotEmpty ? null : "Last name cannot be empty";
    emit(state.copyWith(lastName: event.lastName, lastNameError: error));
    print("Updated State: ${state.lastName}, Error: ${state.lastNameError}");
  }

  void _onUserSignUpEmail(UserSignUpEmail event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpEmail - ${event.email}");
    final error = _isValidEmail(event.email) ? null : "Invalid email format";
    emit(state.copyWith(email: event.email, emailError: error));
    print("Updated State: ${state.email}, Error: ${state.emailError}");
  }

  void _onUserSignUpPhoneNumber(UserSignUpPhoneNumber event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpPhoneNumber - ${event.phoneNumber}");
    final error = _isValidPhoneNumber(event.phoneNumber) ? null : "Invalid phone number";
    emit(state.copyWith(phoneNumber: event.phoneNumber, phoneNumberError: error));
    print("Updated State: ${state.phoneNumber}, Error: ${state.phoneNumberError}");
  }

  void _onUserSignUpAddress(UserSignUpAddress event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpAddress - ${event.address}");
    final error = event.address.isNotEmpty ? null : "Address cannot be empty";
    emit(state.copyWith(address: event.address, addressError: error));
    print("Updated State: ${state.address}, Error: ${state.addressError}");
  }

  void _onUserSignUpDob(UserSignUpDob event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpDob - ${event.dob}");
    final error = _isValidDate(event.dob) ? null : "Invalid date format (YYYY-MM-DD)";
    emit(state.copyWith(dob: event.dob, dobError: error));
    print("Updated State: ${state.dob}, Error: ${state.dobError}");
  }

  void _onUserSignUpPassword(UserSignUpPassword event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpPassword - [HIDDEN]");
    final error = event.password.length >= 6 ? null : "Password must be at least 6 characters";
    emit(state.copyWith(password: event.password, passwordError: error));
    print("Updated State: Password set, Error: ${state.passwordError}");
  }

  void _onUserSignUpGender(UserSignUpGender event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpGender - ${event.gender}");
    final error = event.gender.isNotEmpty ? null : "Gender cannot be empty";
    emit(state.copyWith(gender: event.gender, genderError: error));
    print("Updated State: ${state.gender}, Error: ${state.genderError}");
  }

  Future<void> _onUserSignUpRequested(UserSignUpSubmit event, Emitter<UserSignUpState> emit) async {
    print("Event: UserSignUpSubmit");
    emit(state.copyWith(status: Status.processing));

    final userData = UserRequest(
      firstName: state.firstName,
      lastName: state.lastName,
      email: state.email,
      phoneNumber: state.phoneNumber,
      address: state.address,
      userType: "user",
      dob: state.dob,
      password: state.password,
      gender: state.gender,
    );

    print("Signup Request-------------->$userData");
    final response = await repository.signUpUser(userData);
    print("Signup Response: $response");

    if (response != null) {
      emit(state.copyWith(
        status: Status.success,
        message: "Signup Successful!",
        currentStep: 7, // Set to the last step number
      ));
    } else {
      emit(state.copyWith(status: Status.failure, message: "Signup Failed"));
    }
  }

  void _onUserSignUpNextStep(UserSignUpNextStep event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpNextStep - Current Step: ${state.currentStep}");
    final error = _validateCurrentStep();
    if (error == null) {
      emit(state.copyWith(currentStep: state.currentStep + 1, message: null, status: Status.success));
      print("Moving to next step: ${state.currentStep}");
    } else {
      emit(state.copyWith(message: error, status: Status.failure));
      print("Validation failed: $error");
    }
  }

  void _onUserSignUpPreviousStep(UserSignUpPreviousStep event, Emitter<UserSignUpState> emit) {
    print("Event: UserSignUpPreviousStep - Current Step: ${state.currentStep}");
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
      print("Moving to previous step: ${state.currentStep}");
    }
  }

  String? _validateCurrentStep() {
    switch (state.currentStep) {
      case 0: // Email
        return _isValidEmail(state.email) ? null : "Invalid email format";

      case 1: // Name (First & Last)
        if (state.firstName.isEmpty) return "First name cannot be empty";
        if (state.lastName.isEmpty) return "Last name cannot be empty";
        return null;

      case 2: // Birthday
        return _isValidDate(state.dob) ? null : "Invalid date format (YYYY-MM-DD)";

      case 3: // Gender
        return state.gender.isNotEmpty ? null : "Gender cannot be empty";

      case 4: // Phone
        return _isValidPhoneNumber(state.phoneNumber) ? null : "Invalid phone number";

      case 5: // Address
        return state.address.isNotEmpty ? null : "Address cannot be empty";

      case 6: // Password
        return state.password.length >= 6 ? null : "Password must be at least 6 characters";

      default:
        return null;
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);
  }

  bool _isValidDate(String dob) {
    return RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dob);
  }
}

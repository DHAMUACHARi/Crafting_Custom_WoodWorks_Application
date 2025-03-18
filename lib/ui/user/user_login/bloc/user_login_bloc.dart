import 'package:bloc/bloc.dart';
import 'package:crafting_custom_woodworks/Network/repository.dart';
import 'package:crafting_custom_woodworks/ui/user/user_login/bloc/user_login_event.dart';
import 'package:crafting_custom_woodworks/ui/user/user_login/bloc/user_login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final Repository repository;

  UserLoginBloc({required this.repository})
      : super(UserLoginState(
    status: Status.data,
  )) {
    on<EmailInput>(_onEmailInput);
    on<PasswordInput>(_onPasswordInput);
    on<LoginSubmit>(_onLoginSubmit);
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<GoogleLogoutEvent>(_onGoogleLogout);
    on<FacebookLoginEvent>(_onFacebookLogin);
    on<FacebookLogoutEvent>(_onFacebookLogout);
  }

  void _onEmailInput(EmailInput event, Emitter<UserLoginState> emit) {
    final isValidEmail = _validateEmail(event.email);
    emit(state.copyWith(
      email: event.email,
      emailValidationMsg: isValidEmail ? null : "Invalid email format",
    ));
  }

  void _onPasswordInput(PasswordInput event, Emitter<UserLoginState> emit) {
    final isValidPassword = _validatePassword(event.password);
    emit(state.copyWith(
      password: event.password,
      passwordValidationMsg: isValidPassword ? null : "Password must be at least 6 characters",
    ));
  }

  Future<void> _onLoginSubmit(LoginSubmit event, Emitter<UserLoginState> emit) async {
    if (!_validateEmail(state.email)) {
      emit(state.copyWith(
        error: "Invalid email format",
        emailValidationMsg: "Invalid email format",
      ));
      return;
    }
    if (!_validatePassword(state.password)) {
      emit(state.copyWith(
        error: "Password must be at least 6 characters",
        passwordValidationMsg: "Password must be at least 6 characters",
      ));
      return;
    }

    emit(state.copyWith(status: Status.processing));
    print("email: ${state.email}");
    print("password: ${state.password}");
    try {
      final response = await repository.login(state.email, state.password);

      if (response != null && response.isValid) {
        emit(state.copyWith(
          status: Status.success,
          error: response.status,
        ));
      } else {
        emit(state.copyWith(
          status: Status.error,
          error: response?.status ?? "Login failed",
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: "Login failed"));
    }
  }
  Future<void> _onGoogleLogin(GoogleLoginEvent event, Emitter<UserLoginState> emit) async {
    emit(state.copyWith(status: Status.processing));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(state.copyWith(status: Status.error, error: "Google sign-in canceled"));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        emit(state.copyWith(
          status: Status.success,
          error: "Google Sign-In Successful",
          email: user.email,
        ));
      } else {
        emit(state.copyWith(status: Status.error, error: "Google Sign-In Failed"));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: "Google Sign-In Error: $e"));
    }
  }



  Future<void> _onFacebookLogin(FacebookLoginEvent event, Emitter<UserLoginState> emit) async {
    emit(state.copyWith(status: Status.processing));
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          emit(state.copyWith(
            status: Status.success,
            error: "Facebook Sign-In Successful",
            email: user.email,
          ));
        } else {
          emit(state.copyWith(status: Status.error, error: "Facebook Sign-In Failed"));
        }
      } else {
        emit(state.copyWith(status: Status.error, error: "Facebook Sign-In Canceled"));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: "Facebook Sign-In Error: $e"));
    }
  }

  Future<void> _onFacebookLogout(FacebookLogoutEvent event, Emitter<UserLoginState> emit) async {
    try {
      await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
      emit(UserLoginState(status: Status.data));
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: "Facebook Sign-Out Failed"));
    }
  }
  Future<void> _onGoogleLogout(GoogleLogoutEvent event, Emitter<UserLoginState> emit) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      emit(UserLoginState(status: Status.data));
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: "Google Sign-Out Failed"));
    }
  }
  bool _validateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }
}

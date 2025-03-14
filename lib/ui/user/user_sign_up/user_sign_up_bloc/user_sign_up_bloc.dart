import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_event.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  UserSignUpBloc() : super(UserSignUpState()) {
    on<UserSignUpEvent>(onUserSignup);
    add(UserSignUpEvent());

  }

  Future<void> onUserSignup(UserSignUpEvent event, Emitter<UserSignUpState> emit) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.100:8060/TinkusDJ/api/users/create"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": "varun",
          "lastName": "Tej",
          "email": "varuntej@example.com",
          "phoneNumber": "0935344321",
          "address": "chittoor",
          "userType": "user",
          "dob": "2020-05-04",
          "password": "varun123",
          "gender": "Male"
        }),
      );

      if (response.statusCode == 201) {
       print("Api Call successfull");
      } else {
        print("Failed to send api call");
      }
    } catch (e) {
      print("Failed to send api call${e}");
    }
  }
}

import 'package:crafting_custom_woodworks/Network/service.dart';
import 'package:crafting_custom_woodworks/models/user_model.dart';

class Repository {
  final Service service;

  Repository({required this.service});

  Future<UserResponse?> signUpUser(UserRequest user) async {
    print('Request call in repositoy');
    return await service.signUp(user);
  }
  // login  respository
  Future<LoginResponseModel?> login(String email, String password) async {
      final response = await service.login(email, password);
      return response;
    }
  }


import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String userType;
  final String dob;
  final String password;
  final String gender;

  UserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.userType,
    required this.dob,
    required this.password,
    required this.gender,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}

@JsonSerializable()
class UserResponse {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? userType;
  final String? dob;
  final String? gender;
  final String? password;
  final String? createTimestamp;
  final String? modifiedTimestamp;

  UserResponse({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.userType,
    this.dob,
    this.gender,
    this.password,
    this.createTimestamp,
    this.modifiedTimestamp,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UsersResponse {
  final UserResponse data;
  final int httpStatus;
  final bool isValid;
  final String status;

  UsersResponse({
    required this.data,
    required this.httpStatus,
    required this.isValid,
    required this.status,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}

// Login response model
@JsonSerializable()
class LoginResponseModel {
  final UserData userData;
  final int httpStatus;
  final bool isValid;
  final String status;

  LoginResponseModel({
    required this.userData,
    required this.httpStatus,
    required this.isValid,
    required this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class UserData {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String createTimestamp;
  final String modifiedTimestamp;
  final String userType;
  final String dob;
  final String password;
  final String gender;

  UserData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.createTimestamp,
    required this.modifiedTimestamp,
    required this.userType,
    required this.dob,
    required this.password,
    required this.gender,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

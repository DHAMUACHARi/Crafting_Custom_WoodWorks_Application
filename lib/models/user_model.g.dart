// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      userType: json['userType'] as String,
      dob: json['dob'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'userType': instance.userType,
      'dob': instance.dob,
      'password': instance.password,
      'gender': instance.gender,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      userId: (json['userId'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      userType: json['userType'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      password: json['password'] as String?,
      createTimestamp: json['createTimestamp'] as String?,
      modifiedTimestamp: json['modifiedTimestamp'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'userType': instance.userType,
      'dob': instance.dob,
      'gender': instance.gender,
      'password': instance.password,
      'createTimestamp': instance.createTimestamp,
      'modifiedTimestamp': instance.modifiedTimestamp,
    };

UsersResponse _$UsersResponseFromJson(Map<String, dynamic> json) =>
    UsersResponse(
      data: UserResponse.fromJson(json['data'] as Map<String, dynamic>),
      httpStatus: (json['httpStatus'] as num).toInt(),
      isValid: json['isValid'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UsersResponseToJson(UsersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'httpStatus': instance.httpStatus,
      'isValid': instance.isValid,
      'status': instance.status,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      userData: UserData.fromJson(json['userData'] as Map<String, dynamic>),
      httpStatus: (json['httpStatus'] as num).toInt(),
      isValid: json['isValid'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'userData': instance.userData,
      'httpStatus': instance.httpStatus,
      'isValid': instance.isValid,
      'status': instance.status,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: (json['userId'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      createTimestamp: json['createTimestamp'] as String,
      modifiedTimestamp: json['modifiedTimestamp'] as String,
      userType: json['userType'] as String,
      dob: json['dob'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'createTimestamp': instance.createTimestamp,
      'modifiedTimestamp': instance.modifiedTimestamp,
      'userType': instance.userType,
      'dob': instance.dob,
      'password': instance.password,
      'gender': instance.gender,
    };

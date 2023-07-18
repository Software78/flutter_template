// ignore_for_file: unused_field

library repository;

import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';

class AuthRepository {
  AuthRepository(
      {AuthRemoteDataSource? authRemoteDataSource,
      AuthLocalDataSource? authLocalDataSource})
      : _authRemoteDataSource = authRemoteDataSource ?? AuthRemoteDataSource(),
        _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource();

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  // Future<Either<({int code, String message}), LoginResponse>> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _authRemoteDataSource.login(
  //       email: email,
  //       password: password,
  //     );
  //     return Right(LoginResponse.fromJson(response.data['data']));
  //   } on DioError catch (e) {
  //     final errorList = e.response?.data['error'] as List?;
  //     final errorMap = errorList?.first as Map<String, dynamic>?;
  //     return Left((
  //       code: e.response?.data['status'] ?? 500,
  //       message: errorMap?.entries.first.value ?? handleDioError(e)
  //     ));
  //   }
  // }
}

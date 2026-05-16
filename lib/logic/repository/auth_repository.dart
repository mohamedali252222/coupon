import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/auth_response/user_response_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../bloc/login/login_state_model.dart';
import '../bloc/signup/sign_up_state_model.dart';
import '../cubit/forgot_password/forgot_password_state_model.dart';

abstract class AuthRepository {
  Future<Either<dynamic, UserResponseModel>> login(LoginStateModel body);

  Future<Either<dynamic, String>> userRegistration(SignUpStateModel body);
  Future<Either<dynamic, String>> newUserVerification(SignUpStateModel body);
  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, dynamic> body);

  Future<Either<Failure, String>> logout(Uri uri);

  Future<Either<dynamic, String>> forgotPassword(Map<String, dynamic> body);
  Future<Either<dynamic, String>> updatePassword(PasswordStateModel body);

  Either<Failure, UserResponseModel> getExistingUserInfo();
}

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<dynamic, UserResponseModel>> login(LoginStateModel body) async {
    try {
      final result = await remoteDataSource.login(body);
      final data = UserResponseModel.fromMap(result);
      localDataSource.cacheUserResponse(data);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> userRegistration(
      SignUpStateModel body) async {
    try {
      final result = await remoteDataSource.userRegistration(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> newUserVerification(
      SignUpStateModel body) async {
    try {
      final result = await remoteDataSource.newUserVerification(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.resendVerificationCode(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

@override
Future<Either<dynamic, String>> forgotPassword(
    Map<String, dynamic> body) async {
  try {
    final result = await remoteDataSource.forgotPassword(body);
    return Right(result);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message, e.statusCode));
  } on InvalidAuthData catch (e) {
    return Left(InvalidAuthData(e.errors));
  }
}

@override
Future<Either<dynamic, String>> updatePassword(
    PasswordStateModel body) async {
  try {
    final result = await remoteDataSource.updatePassword(body);
    return Right(result);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message, e.statusCode));
  } on InvalidAuthData catch (e) {
    return Left(InvalidAuthData(e.errors));
  }
}

  @override
  Either<Failure, UserResponseModel> getExistingUserInfo() {
    try {
      final result = localDataSource.getExistingUserInfo();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logout(Uri uri) async {
    try {
      final logout = await remoteDataSource.logout(uri);
      localDataSource.clearUserResponse();
      return Right(logout);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

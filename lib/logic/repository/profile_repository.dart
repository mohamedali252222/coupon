import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/auth_response/user_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../cubit/change_password/change_password_cubit.dart';
import '../cubit/profile/profile_state_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserModel>> getUserProfileInfo(
      String token, String langCode);

  Future<Either<dynamic, String>> updateUserInfo(
      ProfileStateModel body, String token, String langCode);

  Future<Either<Failure, String>> passwordChange(
      ChangePasswordStateModel changePassData, String token, String langCode);
}

class ProfileRepositoryImp extends ProfileRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> getUserProfileInfo(
      String token, String langCode) async {
    try {
      final result = await remoteDataSource.getUserProfileInfo(token, langCode);
      final data = UserModel.fromMap(result['user']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> updateUserInfo(
      ProfileStateModel body, String token, String langCode) async {
    try {
      final result =
          await remoteDataSource.updateUserInfo(body, token, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> passwordChange(
      ChangePasswordStateModel changePassData,
      String token,
      String langCode) async {
    try {
      final result = await remoteDataSource.passwordChange(
          changePassData, token, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/withdraw/account_info_model.dart';
import '../../data/models/withdraw/seller_withdraw_info.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../cubit/withdraw/create_withdraw/create_withdraw_state_model.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, AccountInfoModel>> getAccountInformation(
      String id, String token, String langCode);

  Future<Either<Failure, SellerWithdrawInfo>> getSellerAllWithdrawInfo(
      String token, String langCode);

  Future<Either<Failure, String>> createNewWithdrawRequest(
      CreateWithdrawStateModel body, String token, String langCode);
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final RemoteDataSource remoteDataSources;

  const WithdrawRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, AccountInfoModel>> getAccountInformation(
      String id, String token, String langCode) async {
    try {
      final result =
          await remoteDataSources.getWithdrawAccountInfo(id, token, langCode);
      final data = AccountInfoModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> createNewWithdrawRequest(
      CreateWithdrawStateModel body, String token, String langCode) async {
    try {
      final result = await remoteDataSources.createNewWithdrawRequest(
          body, token, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, SellerWithdrawInfo>> getSellerAllWithdrawInfo(
      String token, String langCode) async {
    try {
      final result =
          await remoteDataSources.getSellerWithdrawInfo(token, langCode);
      final data = SellerWithdrawInfo.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

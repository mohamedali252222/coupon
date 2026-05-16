import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/setting/website_setup_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class WebsiteSetupRepository {
  Future<Either<Failure, WebsiteSetupModel>> getWebsiteSetupData();

  Either<Failure, WebsiteSetupModel> getCatchWebsiteSetupData();

  Either<Failure, bool> checkOnBoarding();

  Future<Either<Failure, bool>> cachedOnBoarding();
}

class WebsiteSetupRepositoryImpl implements WebsiteSetupRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  const WebsiteSetupRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, WebsiteSetupModel>> getWebsiteSetupData() async {
    try {
      final result = await remoteDataSource.getWebsiteSetupData();
      final data = WebsiteSetupModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, WebsiteSetupModel> getCatchWebsiteSetupData() {
    try {
      final result = localDataSource.getCatchWebsiteSetupData();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> cachedOnBoarding() async {
    try {
      final result = await localDataSource.cachedOnBoarding();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      return Right(localDataSource.checkOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}

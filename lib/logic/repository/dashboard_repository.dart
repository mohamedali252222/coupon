import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/search/search_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class DashboardRepository {
  Future<Either<Failure, SearchResponseModel>> getUserPortfolio(
      String token, String langCode);

  Future<Either<Failure, String>> deleteProduct(
      String id, String token, String langCode);
}

class DashboardRepositoryImpl implements DashboardRepository {
  final RemoteDataSource remoteDataSource;

  const DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SearchResponseModel>> getUserPortfolio(
      String token, String langCode) async {
    try {
      final result = await remoteDataSource.getUserPortfolio(token, langCode);
      final data = SearchResponseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(
      String id, String token, String langCode) async {
    try {
      final result = await remoteDataSource.deleteProduct(id, token, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

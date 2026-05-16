import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/search/search_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResponseModel>> getSearchProperty(Uri uri);

  Future<Either<Failure, SearchResponseModel>> getFilterProductByName(Uri uri);

  Future<Either<Failure, SearchResponseModel>> getAllProductList(
      String langCode);
}

class SearchRepositoryImpl implements SearchRepository {
  final RemoteDataSource remoteDataSource;

  const SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SearchResponseModel>> getSearchProperty(
      Uri uri) async {
    try {
      final result = await remoteDataSource.getSearchProperty(uri);
      final data = SearchResponseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SearchResponseModel>> getFilterProductByName(
      Uri uri) async {
    try {
      final result = await remoteDataSource.getFilterProductByName(uri);
      final data = SearchResponseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SearchResponseModel>> getAllProductList(
      String langCode) async {
    try {
      final result = await remoteDataSource.getAllProductList(langCode);
      final data = SearchResponseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

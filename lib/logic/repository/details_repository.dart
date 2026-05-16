import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/details/product_details_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class DetailsRepository {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String slug, String langCode);

  Future<Either<dynamic, String>> sendMessageToAuthor(
      String token, Map<String, dynamic> body, String langCode);

  Future<Either<dynamic, String>> postComment(
      String token, Map<String, dynamic> body, String langCode);

  Future<Either<dynamic, String>> postReview(
      String token, Map<String, dynamic> body, String langCode);
}

class DetailsRepositoryImpl implements DetailsRepository {
  final RemoteDataSource remoteDataSource;

  DetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String slug, String langCode) async {
    try {
      final result = await remoteDataSource.getProductDetails(slug, langCode);
      final data = ProductDetailsModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> sendMessageToAuthor(
      String token, Map<String, dynamic> body, String langCode) async {
    try {
      final result =
          await remoteDataSource.sendMessageToAuthor(token, body, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> postComment(
      String token, Map<String, dynamic> body, String langCode) async {
    try {
      final result = await remoteDataSource.postComment(token, body, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> postReview(
      String token, Map<String, dynamic> body, String langCode) async {
    try {
      final result = await remoteDataSource.postReview(token, body, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}

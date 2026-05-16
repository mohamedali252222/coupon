import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/details/product_item_model.dart';
import '../../data/models/home/home_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeData(String langCode);

  // Future<Either<Failure, List<SingleCategoryModel>>> getCategoryList();
  //
  Future<Either<Failure, List<ProductItemModel>>> getBestSellingProduct(
      String langCode);
}

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeModel>> getHomeData(String langCode) async {
    try {
      final result = await remoteDataSource.getHomeData(langCode);
      print(result);
      final data = HomeModel.fromMap(result);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //
  // @override
  // Future<Either<Failure, List<SingleCategoryModel>>> getCategoryList() async {
  //   try {
  //     final result = await remoteDataSource.getCategoryList();
  //     final categories = result['categories'] as List<dynamic>;
  //     final data = List<SingleCategoryModel>.from(
  //         categories.map((e) => SingleCategoryModel.fromMap(e))).toList();
  //     return Right(data);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

  @override
  Future<Either<Failure, List<ProductItemModel>>> getBestSellingProduct(
      String langCode) async {
    try {
      final result = await remoteDataSource.getBestSellingProduct(langCode);
      final data = result['products']['data'] as List<dynamic>;
      final bestProduct = List<ProductItemModel>.from(
          data.map((e) => ProductItemModel.fromMap(e))).toList();
      return Right(bestProduct);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/wishlist/wishlist_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class WishListRepository {
  Future<Either<Failure, List<WishlistModel>>> getWishItemList(
      String token, String langCode);

  Future<Either<Failure, String>> deleteWishItem(
      String id, String token, String langCode);

  Future<Either<Failure, String>> addToWish(
      String id, String token, String langCode);
}

class WishListRepositoryImp extends WishListRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  WishListRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<WishlistModel>>> getWishItemList(
      String token, String langCode) async {
    try {
      final result = await remoteDataSource.getWishItemList(token, langCode);
      final data = result['wishlists'] as List<dynamic>;
      final wishlist =
          List<WishlistModel>.from(data.map((e) => WishlistModel.fromMap(e)))
              .toList();
      return Right(wishlist);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteWishItem(
      String id, String token, String langCode) async {
    try {
      final result =
          await remoteDataSource.deleteWishListItem(id, token, langCode);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addToWish(
      String id, String token, String langCode) async {
    try {
      final result = await remoteDataSource.addToWish(id, token, langCode);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

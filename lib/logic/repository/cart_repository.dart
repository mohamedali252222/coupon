import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/cart/add_to_cart_model.dart';
import '../../data/models/cart/cart_model.dart';
import '../../data/models/cart/coupon_model.dart';
import '../../data/models/payment/payment_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../cubit/stripe_payment/stripe_payment_state_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCartProduct(
      String token, String langCode);

  Future<Either<Failure, String>> addToCart(
      String token, AddToCartModel dataModel, String langCode);

  Future<Either<Failure, String>> removeCartItem(
      String id, String token, String langCode);

  Future<Either<Failure, PaymentModel>> getPaymentPageInformation(
      String token, String langCode);

  Future<Either<Failure, String>> bankPayment(
      Uri uri, Map<String, dynamic> body);

  Future<Either<Failure, String>> stripePayment(
      Uri uri, StripePaymentStateModel body);

  Future<Either<Failure, int>> cartQty(String token);

  // Future<Either<Failure, PaymentModel>> getCheckout(String token);

  Future<Either<Failure, CouponDto>> applyCoupon(
      Map<String, String> coupon, String token, String langCode);

  Either<Failure, CouponDto> fetchCouponData();

  Either<Failure, bool> removeCoupon();
}

class CartRepositoryImpl implements CartRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  CartRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, CartModel>> getCartProduct(
      String token, String langCode) async {
    try {
      final result = await remoteDataSource.getCartProduct(token, langCode);
      final data = CartModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removeCartItem(
      String id, String token, String langCode) async {
    try {
      final result = await remoteDataSource.removeCartItem(id, token, langCode);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PaymentModel>> getPaymentPageInformation(
      String token, String langCode) async {
    try {
      final result =
          await remoteDataSource.getPaymentPageInformation(token, langCode);
      final data = PaymentModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CouponDto>> applyCoupon(
      Map<String, String> coupon, String token, String langCode) async {
    try {
      final result =
          await remoteDataSource.applyCoupon(coupon, token, langCode);
      final data = CouponDto.fromMap(result);
      localDataSource.cacheCouponResponse(data);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(
      String token, AddToCartModel dataModel, String langCode) async {
    try {
      final result =
          await remoteDataSource.addToCart(token, dataModel, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> bankPayment(
      Uri uri, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.bankPayment(uri, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> stripePayment(
      Uri uri, StripePaymentStateModel body) async {
    try {
      final result = await remoteDataSource.stripePayment(uri, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, int>> cartQty(String token) async {
    try {
      final result = await remoteDataSource.cartQty(token);

      final data = int.parse(result['cart_qty'].toString());
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, PaymentModel>> getCheckout(String token) async {
  //   try {
  //     final result = await remoteDataSource.getCheckOutInfo(token);
  //     final data = PaymentModel.fromMap(result);
  //     return Right(data);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

  @override
  Either<Failure, CouponDto> fetchCouponData() {
    try {
      final result = localDataSource.getCouponData();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> removeCoupon() {
    try {
      // ignore: unused_local_variable
      final result = localDataSource.clearCouponResponse();
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}

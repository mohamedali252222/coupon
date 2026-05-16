import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/data_provider/remote_url.dart';
import '../../data/models/edit/edit_product_model.dart';
import '../../data/models/upload_product/product_type_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../../presentation/utils/utils.dart';
import '../bloc/upload_product/upload_product_state_model.dart';
import '../cubit/update/update_state_model.dart';
import '../cubit/variant/variant_state_model.dart';

abstract class UploadProductRepository {
  Future<Either<Failure, ProductTypeModel>> getSelectProductTypeInfo(
      String token, String langCode);

  Future<Either<dynamic, String>> uploadProduct(
      String token, String type, String langCode, UploadProductStateModel body);

  Future<Either<dynamic, String>> updateProduct(String token, String id,
      String type, String langCode, UpdateStateModel body);

  // Future<Either<Failure, String>> deleteProduct(
  //     String token, String id, String langCode);

  Future<Either<Failure, bool>> downloadExistingScriptFile(
      String token, String id, String langCode);

  Future<Either<dynamic, String>> uploadVariant(
      String token, String id, String langCode, VariantStateModel body);

  Future<Either<dynamic, String>> updateVariant(
      String token, String id, String langCode, VariantStateModel body);

  Future<Either<Failure, String>> deleteVariant(
      String token, String id, String langCode);

  Future<Either<Failure, EditProductModel>> getEditProductInfo(
      String token, String id, String langCode);
}

class UploadProductRepositoryImpl implements UploadProductRepository {
  final RemoteDataSource remoteDataSource;

  const UploadProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductTypeModel>> getSelectProductTypeInfo(
      String token, String langCode) async {
    try {
      final result =
          await remoteDataSource.getSelectProductTypeInfo(token, langCode);
      final data = ProductTypeModel.fromMap(result['product_type_page']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> uploadProduct(String token, String langCode,
      String type, UploadProductStateModel body) async {
    try {
      final result =
          await remoteDataSource.uploadProduct(token, langCode, type, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> updateProduct(String token, String id,
      String type, String langCode, UpdateStateModel body) async {
    try {
      final result =
          await remoteDataSource.updateProduct(token, id, type, langCode, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> uploadVariant(
      String token, String id, String langCode, VariantStateModel body) async {
    try {
      final result =
          await remoteDataSource.uploadVariant(token, id, langCode, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> updateVariant(
      String token, String id, String langCode, VariantStateModel body) async {
    try {
      final result =
          await remoteDataSource.updateVariant(token, id, langCode, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(
      String token, String id, String langCode) async {
    try {
      final result = await remoteDataSource.deleteProduct(token, id, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteVariant(
      String token, String id, String langCode) async {
    try {
      final result = await remoteDataSource.deleteVariant(token, id, langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, EditProductModel>> getEditProductInfo(
      String token, String id, String langCode) async {
    try {
      final result =
          await remoteDataSource.getEditProductInfo(token, id, langCode);
      final data = EditProductModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadExistingScriptFile(
      String token, String id, String langCode) async {
    // static String downloadExistingScriptFile(String token, String file) =>
    // '${baseUrl}download-existing-file/$file?token=$token';
    const rootUrl = RemoteUrls.baseUrl;
    // final endPoint =
    //     'download-existing-file/$downloadFile?token=$token&lang_code=$langCode';
    final endPoint =
        'personal-download-script/$id?token=$token&lang_code=$langCode';
    final fileName = DateTime.now().millisecondsSinceEpoch;
    final dir = await Utils.getDir();

    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = rootUrl + endPoint;
      print("url : $myUrl");
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();

      print("response : $response");
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response,
            autoUncompress: false);
        // filePath = '$dir/test.zip';
        filePath = '$dir/$fileName.zip';
        file = File(filePath);
        final v = await file.writeAsBytes(bytes);
        debugPrint("check file $bytes");
      } else {
        filePath = 'Error code: ${response.statusCode}';
        return const Right(false);
      }
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }

    //return filePath;
  }

// @override
// Future<Either<Failure, String>> downloadExistingScriptFile(
//     String token, String file) async {
//   try {
//     final result =
//         await remoteDataSource.downloadExistingScriptFile(token, file);
//     return Right(result);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   }
// }
}

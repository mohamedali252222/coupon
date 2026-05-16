import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import '../../data/data_provider/remote_data_source.dart';
import '../../data/data_provider/remote_url.dart';
import '../../data/models/download/download_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../../presentation/utils/utils.dart';

abstract class DownloadRepository {
  Future<Either<Failure, List<DownloadItem>>> getDownloadItems(
      String token, String langCode);

  Future<Either<Failure, bool>> downloadFiles(
      String id, String token, String langCode);

  Future<Either<Failure, bool>> downloadVariantFiles(
      String id, String token, String langCode);
}

class DownloadRepositoryImpl implements DownloadRepository {
  final RemoteDataSource remoteDataSource;

  DownloadRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DownloadItem>>> getDownloadItems(
      String token, String langCode) async {
    try {
      final result = await remoteDataSource.downloadItems(token, langCode);
      final data = result['order_items']['data'] as List<dynamic>;
      final items =
          List<DownloadItem>.from(data.map((e) => DownloadItem.fromMap(e)))
              .toList();
      return Right(items);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadFiles(
      String id, String token, String langCode) async {
    const rootUrl = RemoteUrls.baseUrl;
    final endPoint =
        'secure-download-script/$id?token=$token&lang_code=$langCode';
    print("download file: $endPoint");
    final fileName = DateTime.now().millisecondsSinceEpoch;
    final dir = await Utils.getDir();

    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = rootUrl + endPoint;
      print('endPoint $myUrl');
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response,
            autoUncompress: false);
        final filePath = path.join(dir, '$fileName.zip');
        print('filePath $filePath');
        print('filename $fileName');
        file = File(filePath);
        await file.writeAsBytes(bytes);
        debugPrint("check file $bytes");
      } else {
        filePath = 'Error code: ${response.statusCode}';
        return const Right(false);
      }
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }

    // return filePath;
  }

  @override
  Future<Either<Failure, bool>> downloadVariantFiles(
      String id, String token, String langCode) async {
    const rootUrl = RemoteUrls.baseUrl;
    final endPoint =
        'secure-download-variant-item/$id?token=$token&lang_code=$langCode';
    final fileName = DateTime.now().millisecondsSinceEpoch;
    final dir = await Utils.getDir();

    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = rootUrl + endPoint;
      print('endPoint $myUrl');
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response,
            autoUncompress: false);
        final filePath = path.join(dir, '$fileName.zip');
        print('filePath $filePath');
        print('filename $fileName');
        file = File(filePath);
        await file.writeAsBytes(bytes);
        debugPrint("check file $bytes");
      } else {
        filePath = 'Error code: ${response.statusCode}';
        return const Right(false);
      }
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }

    // return filePath;
  }
}

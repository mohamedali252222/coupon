import 'package:dartz/dartz.dart';

import '/data/data_provider/remote_data_source.dart';
import '../../data/models/about_us/about_us_model.dart';
import '../../data/models/contact_us/contact_us_model.dart';
import '../../data/models/faq/faq_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';
import '../cubit/contact_us/contact_us_state_model.dart';

abstract class GeneralRepository {
  Future<Either<Failure, List<FaqContent>>> getFaqContent(String langCode);

  Future<Either<Failure, String>> getPrivacyPolicy(String langCode);

  Future<Either<Failure, String>> getTermsAndCondition(String langCode);

  Future<Either<Failure, AboutUsModel>> getAboutUs(String langCode);

  Future<Either<Failure, ContactComponent>> getContactUs(String langCode);

  Future<Either<Failure, String>> sendContactUsMessage(
      ContactUsStateModel body);
}

class GeneralRepositoryImpl implements GeneralRepository {
  final RemoteDataSource remoteDataSource;

  const GeneralRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FaqContent>>> getFaqContent(
      String langCode) async {
    try {
      final result = await remoteDataSource.getFaqContent(langCode);
      final data = result['faqs'] as List<dynamic>;
      final faqs = List<FaqContent>.from(data.map((e) => FaqContent.fromMap(e)))
          .toList();
      print('faq-length ${faqs.length}');
      return Right(faqs);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AboutUsModel>> getAboutUs(String langCode) async {
    try {
      final result = await remoteDataSource.getAboutUs(langCode);
      final data = AboutUsModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> getPrivacyPolicy(String langCode) async {
    try {
      final result = await remoteDataSource.getPrivacyPolicy(langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> getTermsAndCondition(String langCode) async {
    try {
      final result = await remoteDataSource.getTermsAndCondition(langCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ContactComponent>> getContactUs(
      String langCode) async {
    try {
      final result = await remoteDataSource.getContactUs(langCode);
      final data = ContactComponent.fromMap(result['contact']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> sendContactUsMessage(
      ContactUsStateModel body) async {
    try {
      final result = await remoteDataSource.sendContactUsMessage(body);
      return Right(result);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

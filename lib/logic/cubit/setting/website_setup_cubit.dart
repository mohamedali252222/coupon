import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/setting/website_setup_model.dart';
import '../../repository/website_setup_repository.dart';

part 'website_setup_state.dart';

class WebsiteSetupCubit extends Cubit<WebsiteSetupState> {
  final WebsiteSetupRepository _repository;

  // Static variable to hold fileBaseUrl once it's set
  static String? _fileBaseUrl;

  WebsiteSetupCubit({required WebsiteSetupRepository repository})
      : _repository = repository,
        super(WebsiteSetupInitial()) {
    //initWebsite();
    getWebsiteSetupData();
  }

  WebsiteSetupModel? setting;

  // Static getter to access fileBaseUrl
  static String? get fileBaseUrl => _fileBaseUrl;

  bool get showOnBoarding =>
      _repository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<void> cacheOnBoarding() async {
    final result = await _repository.cachedOnBoarding();
    result.fold((l) => false, (r) => r);
  }

  void initWebsite() async {
    emit(WebsiteSetupLoading());

    final result = await _repository.getCatchWebsiteSetupData();
    result.fold(
        (l) => emit(
              WebsiteSetupError(l.message, l.statusCode),
            ), (success) {
      setting = success;
      _fileBaseUrl = success.fileBaseUrl;
      emit(WebsiteSetupLoaded(success));
    });
  }

  Future<void> getWebsiteSetupData() async {
    emit(WebsiteSetupLoading());

    final result = await _repository.getWebsiteSetupData();
    result.fold(
        (l) => emit(
              WebsiteSetupError(l.message, l.statusCode),
            ), (success) {
      setting = success;
      _fileBaseUrl = success.fileBaseUrl;
      emit(WebsiteSetupLoaded(success));
    });
  }
}

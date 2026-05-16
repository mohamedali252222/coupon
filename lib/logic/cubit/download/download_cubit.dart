import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/download/download_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../state_packages_name.dart';
import '../language_code_state.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<LanguageCodeState> {
  final DownloadRepository _downloadRepository;
  final LoginBloc _loginBloc;

  //DownloadModel? downloadModel;
  List<DownloadItem> downloadItems = [];

  DownloadCubit({
    required DownloadRepository downloadRepository,
    required LoginBloc loginBloc,
  })  : _downloadRepository = downloadRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  Future<void> getDownloadItems() async {
    print("download item");
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(downloadState: DownloadLoadingState()));
    final result = await _downloadRepository.getDownloadItems(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold(
      (failure) {
        final errors = DownloadErrorState(failure.message, failure.statusCode);
        emit(state.copyWith(downloadState: errors));
      },
      (success) {
        downloadItems = success;
        final successState = DownloadDataLoaded(success);
        emit(state.copyWith(downloadState: successState));
      },
    );
  }

  Future<Either<Failure, bool>> downloadFile(String id) async {
    print("download file call");
    // emit(DownloadLoadingState());
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    final result = await _downloadRepository.downloadFiles(
        id, _loginBloc.userInformation!.accessToken, state.languageCode);

    return result;
  }

  Future<Either<Failure, bool>> downloadVariantFile(String id) async {
    // emit(DownloadLoadingState());
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    final result = await _downloadRepository.downloadVariantFiles(
        id, _loginBloc.userInformation!.accessToken, state.languageCode);

    return result;
  }
}

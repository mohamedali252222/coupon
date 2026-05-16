part of 'download_cubit.dart';

class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadInitial extends DownloadState {
  const DownloadInitial();

  @override
  List<Object> get props => [];
}

class DownloadLoadingState extends DownloadState {}

class DownloadErrorState extends DownloadState {
  final String message;
  final int statusCode;

  const DownloadErrorState(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class DownloadDataLoaded extends DownloadState {
  final List<DownloadItem> downloadModel;

  const DownloadDataLoaded(this.downloadModel);

  @override
  List<Object> get props => [downloadModel];
}

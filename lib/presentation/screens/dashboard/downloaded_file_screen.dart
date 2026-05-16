import 'package:flutter/material.dart';

import '../../../data/models/download/download_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../state_packages_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/downloaded_component.dart';

class DownloadedFileScreen extends StatelessWidget {
  const DownloadedFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadCubit = context.read<DownloadCubit>();
    downloadCubit.getDownloadItems();
    return Scaffold(
      body: BlocConsumer<DownloadCubit, LanguageCodeState>(
        listener: (context, state) {
          final download = state.downloadState;
          if (download is DownloadErrorState) {
            if (downloadCubit.downloadItems.isNotEmpty ||
                download.statusCode == 503) {
              downloadCubit.getDownloadItems();
            }
          }
        },
        builder: (context, state) {
          final download = state.downloadState;
          if (download is DownloadLoadingState) {
            return const Center(child: LoaderCircle());
          } else if (download is DownloadErrorState) {
            if (download.statusCode == 503) {
              if (downloadCubit.downloadItems.isNotEmpty) {
                return LoadedDownloadWidget(
                    download: downloadCubit.downloadItems);
              }
            } else {
              return const FetchErrorText(text: 'Network problem');
            }
            return FetchErrorText(text: download.message);
          } else if (download is DownloadDataLoaded) {
            // DownloadModel
            return LoadedDownloadWidget(download: download.downloadModel);
          }
          if (downloadCubit.downloadItems.isNotEmpty) {
            return LoadedDownloadWidget(download: downloadCubit.downloadItems);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedDownloadWidget extends StatelessWidget {
  const LoadedDownloadWidget({super.key, required this.download});

  final List<DownloadItem> download;

  @override
  Widget build(BuildContext context) {
    debugPrint('downloaded-product ${download[0].product}');
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Downloaded File',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        if (download.isNotEmpty) ...[
          SliverList.list(
            children: List.generate(
              download.length,
              (index) {
                final theme = download[index];
                return DownloadedComponent(
                  theme: theme,
                );
              },
            ),
          ),
        ] else ...[
          EmptyWidget(
            icon: KImages.emptyDownload,
            text: 'Your Download is Empty',
          ),
        ]
      ],
    );
  }
}

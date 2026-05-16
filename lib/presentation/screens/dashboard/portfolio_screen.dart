import 'package:alas_mart/presentation/routes/routes_name.dart';
import 'package:alas_mart/presentation/utils/utils.dart';
import 'package:alas_mart/presentation/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/search/search_model.dart';
import '../../../logic/cubit/dashboard/dashboard_cubit.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/portfolio_component.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dashboardCubit = context.read<DashboardCubit>();
    dashboardCubit.getUserPortfolio();
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      body: BlocConsumer<DashboardCubit, LanguageCodeState>(
        listener: (context, state) {
          final portfolio = state.dashboardState;
          if (portfolio is DashboardUserPortfolioError) {
            if (dashboardCubit.portfolio == null ||
                portfolio.statusCode == 503) {
              dashboardCubit.getUserPortfolio();
            }
          }
        },
        builder: (context, state) {
          final portfolio = state.dashboardState;
          if (portfolio is DashboardUserPortfolioLoading) {
            return const Center(child: LoaderCircle());
          } else if (portfolio is DashboardUserPortfolioError) {
            if (portfolio.statusCode == 503) {
              if (dashboardCubit.portfolio != null) {
                return PortfolioLoadedWidget(
                    portfolio: dashboardCubit.portfolio!);
              }
            } else {
              return const FetchErrorText(text: 'Network problem');
            }
            return FetchErrorText(text: portfolio.message);
          } else if (portfolio is DashboardUserPortfolioLoaded) {
            return PortfolioLoadedWidget(portfolio: portfolio.portfolio);
          }
          if (dashboardCubit.portfolio != null) {
            return PortfolioLoadedWidget(portfolio: dashboardCubit.portfolio!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class PortfolioLoadedWidget extends StatelessWidget {
  const PortfolioLoadedWidget({super.key, required this.portfolio});

  final SearchResponseModel portfolio;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'My Portfolio',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        SliverToBoxAdapter(child: Utils.verticalSpace(12.0)),
        if (portfolio.products!.isNotEmpty) ...[
          SliverList.list(
            children: List.generate(
              portfolio.products!.length,
              (index) {
                final theme = portfolio.products![index];
                return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteNames.detailScreen,
                        arguments: theme.slug),
                    child: PortfolioComponent(theme: theme));
              },
            ),
          ),
        ] else ...[
          EmptyWidget(
            icon: KImages.emptyDownload,
            text: 'No Portfolio found',
            isSliver: true,
          ),
        ],
        SliverToBoxAdapter(child: Utils.verticalSpace(20.0)),
      ],
    );
  }
}

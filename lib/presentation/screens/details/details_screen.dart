import 'package:flutter/material.dart';

import '../../../data/models/details/product_details_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/variant/variant_state_model.dart';
import '../../../state_packages_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/bottom_add_to_cart.dart';
import 'component/product_information.dart';
import 'component/product_tab_content.dart';
import 'component/relative_product_card.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.slug});

  final String slug;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<DetailsCubit>().getProductDetails(widget.slug));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<DetailsCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocListener<VariantCubit, VariantStateModel>(
        listener: (context, state) {
          final v = state.variantState;
          if (v is VariantUploaded) {
            detailsCubit.getProductDetails(widget.slug);
          }
        },
        child: BlocConsumer<DetailsCubit, LanguageCodeState>(
          listener: (context, state) {
            final detail = state.detailsState;
            if (detail is DetailsError) {
              if (detail.statusCode == 503 || detailsCubit.details == null) {
                detailsCubit.getProductDetails(widget.slug);
              }
              else if (detail.statusCode == 401) {
                loginBloc.add(const LoginEventLogout());
              } else {
                Utils.errorSnackBar(context, detail.message);
              }
            }
          },
          builder: (context, state) {
            final detail = state.detailsState;
            if (detail is DetailsLoading) {
              return const Center(child: LoaderCircle());
            } else if (detail is DetailsError) {
              if (detail.statusCode == 503) {
                if (detailsCubit.details != null) {
                  return LoadedDetailsComponent(details: detailsCubit.details!);
                } else {
                  return const FetchErrorText(text: 'Network problem');
                }
              }
              return FetchErrorText(text: detail.message);
            } else if (detail is DetailsLoaded) {
              return LoadedDetailsComponent(details: detail.details);
            }
            if (detailsCubit.details != null) {
              return LoadedDetailsComponent(details: detailsCubit.details!);
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<DetailsCubit, LanguageCodeState>(
        builder: (context, state) {
          final detail = state.detailsState;
          if (detail is DetailsLoaded) {
            return BottomAddToCart(details: detail.details);
          }
          if (detail is DetailsLoading) {
            return const SizedBox.shrink();
          }
          if (detailsCubit.details != null) {
            return BottomAddToCart(details: detailsCubit.details!);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class LoadedDetailsComponent extends StatelessWidget {
  const LoadedDetailsComponent({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  Widget build(BuildContext context) {
    debugPrint('product_id ${details.product!.id}');
    debugPrint('product_type ${details.product!.productType}');
    //debugPrint('price_type${details.product!.pr} ');
    debugPrint('variants ${details.variants!.length}');
    return CustomScrollView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      slivers: [
        const CustomSliverAppBar(
          title: 'Product Details',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        ProductInformation(details: details),
        ProductTabContent(details: details),
        RelativeProductCard(relatedProducts: details.relatedProducts!),
        SliverToBoxAdapter(
          child: Utils.verticalSpace(0.0),
        ),
      ],
    );
  }
}

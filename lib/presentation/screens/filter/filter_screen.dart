import 'package:flutter/material.dart';

import '../../../data/models/search/search_model.dart';
import '../../../logic/cubit/filter/filter_state_model.dart';
import '../../../state_packages_name.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loading_widget.dart';
import '../search/component/search_items.dart';
import 'component/filter_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.keyword});

  final String keyword;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    if (widget.keyword.isEmpty) {
      context.read<FilterCubit>().getAllProductList();
    } else {
      context.read<FilterCubit>().getFilterProductByName(widget.keyword);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('key-name ${widget.keyword}');
    final filterCubit = context.read<FilterCubit>();
    //print('prrrrr ${filterCubit.product}');
    if (widget.keyword.isNotEmpty) {
      if (filterCubit.product == null) {
        filterCubit.getFilterProductByName(widget.keyword);
        print('loaded with key again');
      } else {
        print('not load with key');
      }
    } else {
      if (filterCubit.product == null) {
        filterCubit.getAllProductList();
        print('loaded without key again');
      } else {
        print('not load without key again');
      }
    }
    filterCubit.changeCategory(widget.keyword);
    return Scaffold(
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: homeBgColor.withOpacity(0.99),
      appBar: const FilterAppBar(),
      //appBar: const CustomAppBar(title: "Product", horSpace: 100.0),
      body: BlocConsumer<FilterCubit, FilterStateModel>(
        listener: (context, state) {
          final filter = state.filterState;
          if (filter is ProductListLoaded) {
            // Utils.showSnackBar(context, 'Loaded');
            filterCubit.clear();
          }
        },
        builder: (context, state) {
          final filter = state.filterState;
          if (filter is FilterStateLoading) {
            return const LoadingWidget();
          } else if (filter is FilterStateError) {
            if (filter.statusCode == 503) {
              if (filterCubit.product != null) {
                return LoadedCategoryByName(items: filterCubit.product!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            } else {
              return FetchErrorText(text: filter.message);
            }
          } else if (filter is ProductListLoaded) {
            return LoadedCategoryByName(items: filter.product);
          }
          if (filterCubit.product != null) {
            return LoadedCategoryByName(items: filterCubit.product!);
          } else {
            return const FetchErrorText(text: 'Something went wrong');
          }
        },
      ),
      endDrawer: const FilterDrawer(),
    );
  }
}

class LoadedCategoryByName extends StatelessWidget {
  const LoadedCategoryByName({super.key, required this.items});

  final SearchResponseModel items;

  @override
  Widget build(BuildContext context) {
    if (items.products!.isNotEmpty) {
      return ListView.builder(
        itemCount: items.products!.length,
        shrinkWrap: true,
        padding: Utils.symmetric(h: 0.0, v: 12.0),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items.products![index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.detailScreen,
                arguments: item.slug),
            child: SearchComponent(theme: item),
          );
        },
      );
    } else {
      return Center(
        child: EmptyWidget(
            icon: KImages.emptyWishlist,
            text: 'No Product Found!',
            isSliver: false),
      );
    }
  }
}

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: scaffoldBgColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actionsIconTheme:
          const IconThemeData(color: primaryColor, size: 30.0, fill: 0.6),
      actions: const [SizedBox()],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  maxRadius: 18.0,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.arrow_back,
                    size: 22.0,
                    color: whiteColor,
                  ),
                ),
              ),
              Utils.horizontalSpace(20.0),
              const CustomText(
                text: 'Product',
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16.0)),
                backgroundColor: MaterialStateProperty.all(primaryColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
                shadowColor: MaterialStateProperty.all(transparent),
                elevation: MaterialStateProperty.all(0.0),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(transparent),
                minimumSize: const MaterialStatePropertyAll(Size(140.0, 36.0))),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            label: const CustomText(
              text: 'Filter',
              color: whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
            icon: const CustomImage(
              path: KImages.filterIcon22,
              color: whiteColor,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

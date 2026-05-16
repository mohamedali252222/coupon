import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/product_item_model.dart';
import '../../../logic/bloc/search/search_bloc.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_widget.dart';
import 'component/search_items.dart';
import 'component/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final searchBloc = context.read<SearchBloc>();
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent - 200;
      if (maxExtent < scrollController.position.pixels) {
        searchBloc.add(const SearchEventLoadMoreProperty());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: homeBgColor.withOpacity(0.99),
        appBar: SearchTextField(
          child: Padding(
            padding: EdgeInsets.only(top: Utils.vPadding(size: 10.0)),
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              controller: searchTextEditingController,
              decoration: InputDecoration(
                  hintText: 'Search property..',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: Utils.vPadding(size: 15.0),
                      horizontal: Utils.hPadding(size: 10.0))),
              onChanged: (String text) {
                if (text.isEmpty) return;
                searchBloc.add(SearchEventProperty(text.trim()));
              },
              onFieldSubmitted: (String text) {
                if (text.isEmpty) return;
                searchBloc.add(SearchEventProperty(text.trim()));
              },
            ),
          ),
        ),
        body: BlocListener<SearchBloc, LanguageCodeState>(
          listener: (context, state) {},
          child: BlocBuilder<SearchBloc, LanguageCodeState>(
            builder: (context, state) {
              final search = state.searchState;
              if (search is SearchLoading) {
                return const LoadingWidget();
              } else if (search is SearchError) {
                //Utils.errorSnackBar(context, state.message);
              } else if (search is SearchLoaded) {
                return SearchItemLoaded(products: search.products);
              }
              return const SizedBox.shrink();
              // return const Center(
              //   child: CustomTextStyle(
              //     text: 'something is wrong',
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }
}

class SearchItemLoaded extends StatelessWidget {
  const SearchItemLoaded({super.key, required this.products});

  final List<ProductItemModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: EmptyWidget(
            icon: KImages.emptyWishlist,
            text: 'No Product Found!',
            isSliver: false),
      );
    } else {
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.detailScreen,
                arguments: product.slug),
            child: SearchComponent(theme: product),
          );
        },
      );
    }
  }
}

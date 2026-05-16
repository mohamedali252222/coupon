import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/details/product_details_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import 'tabs/author_profile_tab.dart';
import 'tabs/comment_tab.dart';
import 'tabs/description_tab.dart';
import 'tabs/product_info_tab.dart';
import 'tabs/review_tab.dart';

class ProductTabContent extends StatefulWidget {
  const ProductTabContent({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  State<ProductTabContent> createState() => _ProductTabContentState();
}

class _ProductTabContentState extends State<ProductTabContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBar = [
      DescriptionTab(product: widget.details.product!),
      CommentTab(comment: widget.details),
      ReviewTab(details: widget.details),
      ProductInfoTab(product: widget.details.product!),
      AuthorProfileTab(author: widget.details.product!.author!),
    ];

    List<String> tabTitle = [
      'Description',
      'Comment',
      'Review',
      'Product Info',
      'Author Profile'
    ];
    List<String> tabIcon = [
      KImages.descriptionTab,
      KImages.comment,
      KImages.review,
      KImages.productInfo,
      KImages.productInfo,
    ];
    return SliverToBoxAdapter(
      child: ExpandablePageView.builder(
        itemCount: tabBar.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Utils.hPadding()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      tabTitle.length,
                      (index) {
                        final active = _currentIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => _currentIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? primaryColor
                                    : whiteColor,
                                borderRadius: Utils.borderRadius(r: 6.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x28000000),
                                    blurRadius: 44,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ]),
                            padding: Utils.symmetric(v: 16.0, h: 22.0),
                            margin: Utils.only(
                                left: index == 0 ? 0.0 : 16.0,
                                bottom: 10.0,
                                top: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomImage(
                                    path: tabIcon[index],
                                    color: active ? whiteColor : grayColor),
                                Utils.horizontalSpace(10.0),
                                CustomText(
                                  text: tabTitle[index],
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: active ? whiteColor : grayColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Utils.verticalSpace(20.0),
              Padding(
                padding: Utils.symmetric(h: 16.0, v: 20.0).copyWith(top: 0.0),
                child: tabBar[_currentIndex],
              ),
            ],
          );
        },
      ),
    );
  }
}

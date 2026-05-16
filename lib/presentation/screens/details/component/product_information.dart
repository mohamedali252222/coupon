import 'package:alas_mart/presentation/screens/details/component/price_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/product_details_model.dart';
import '../../../../data/models/details/variant/variant_model.dart';
import '../../../../logic/cubit/details/details_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/product_rating.dart';
import 'script_product_content.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  double variantPrice = 0.0;

  @override
  void initState() {
    if (widget.details.firstVariant != null) {
      if (widget.details.product!.productType != 'script') {
        variantPrice = widget.details.firstVariant!.price;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = widget.details;
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          margin: Utils.symmetric(v: 12.0),
          height: size.height * 0.3,
          width: size.width,
          padding: Utils.all(value: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: Utils.borderRadius(),
            boxShadow: const [
              BoxShadow(
                color: Color(0x23000000),
                blurRadius: 60,
                offset: Offset(10, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: Utils.borderRadius(),
            child: CustomImage(
              path: RemoteUrls.imageUrl(product.product!.thumbnailImage),
              //path: KImages.detailImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: Utils.symmetric(),
          decoration: BoxDecoration(
            color: grayColor2,
            borderRadius: Utils.borderRadius(r: 6.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (product.product!.productType == 'script') ...[
                ScriptProductContent(details: widget.details),
              ] else ...[
                if (product.firstVariant != null) ...[
                  PriceSection(
                      price: variantPrice, totalSale: product.totalSale),
                  DropdownButtonFormField<VariantModel>(
                    isDense: true,
                    isExpanded: true,
                    hint: CustomText(
                      text: product.firstVariant!.variantName ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    items: product.variants!
                        .map<DropdownMenuItem<VariantModel>>(
                          (VariantModel e) => DropdownMenuItem(
                            value: e,
                            child: CustomText(
                              text: e.variantName,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      //print(value!.id.toString());
                      setState(() {
                        variantPrice = value!.price;
                        context.read<DetailsCubit>().selectedVariant = value;
                        debugPrint(
                            "id: ${value.id} | name: ${value.variantName}");
                      });
                    },
                  ),
                ] else ...[
                  const SizedBox.shrink(),
                ],
              ],
              Padding(
                padding: Utils.symmetric(h: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: product.product!.productType,
                            fontSize: 16.0,
                            color: primaryColor),
                        ProductRating(
                            rating: product.product!.averageRating.toInt()),
                      ],
                    ),
                    Utils.verticalSpace(14.0),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomText(
                        text: product.product!.productLangFrontEnd!.name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        maxLine: 4,
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(10.0),
            ],
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../logic/cubit/filter/filter_cubit.dart';
import '../../../../logic/cubit/filter/filter_state_model.dart';
import '../../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../../utils/constraints.dart';

class PriceSection extends StatefulWidget {
  const PriceSection({Key? key, required this.totalPrice}) : super(key: key);
  final double totalPrice;

  @override
  State<PriceSection> createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  RangeValues? priceRangeValue;
  double minPriceValue = 0.0;
  double? maxPriceValue;

  @override
  void initState() {
    super.initState();
    priceRangeValue = RangeValues(0, widget.totalPrice);
    maxPriceValue = widget.totalPrice;
    setInitialValue();
  }

  setInitialValue() {
    final filterCubit = context.read<FilterCubit>();
    filterCubit.changeMinPrice(minPriceValue.toStringAsFixed(0));
    filterCubit.changeMaxPrice(maxPriceValue!.toStringAsFixed(0));
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        context.read<WebsiteSetupCubit>().setting!.setting!.currencyIcon;
    final filterCubit = context.read<FilterCubit>();
    RangeLabels labels = RangeLabels(
        minPriceValue.round().toString(), maxPriceValue!.round().toString());
    return BlocBuilder<FilterCubit, FilterStateModel>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor2),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RangeSlider(
                values: priceRangeValue!,
                min: 0,
                max: widget.totalPrice,
                activeColor: primaryColor,
                inactiveColor: grayColor.withOpacity(0.2),
                labels: labels,
                onChanged: (RangeValues values) {
                  priceRangeValue = values;
                  minPriceValue = double.parse(values.start.round().toString());
                  maxPriceValue = double.parse(values.end.round().toString());
                  filterCubit.changeMinPrice(minPriceValue.toStringAsFixed(0));
                  filterCubit.changeMaxPrice(maxPriceValue!.toStringAsFixed(0));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: icon,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: blackColor,
                          ),
                        ),
                        TextSpan(
                            text: minPriceValue.toStringAsFixed(0),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: blackColor,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 10.0,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 4.0),
                    padding: const EdgeInsets.only(top: 0.0),
                    color: redColor,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: icon,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: blackColor,
                          ),
                        ),
                        TextSpan(
                          text: maxPriceValue!.toStringAsFixed(0),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

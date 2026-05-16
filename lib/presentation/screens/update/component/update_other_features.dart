import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/update/update_cubit.dart';
import '../../../../logic/cubit/update/update_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class UpdateOtherFeature extends StatelessWidget {
  const UpdateOtherFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadBloc = context.read<UpdateCubit>();
    return BlocBuilder<UpdateCubit, UpdateStateModel>(
      builder: (context, state) {
        String resolution = state.highResolution;
        String crossBrowser = state.crossBrowser;
        String documentation = state.documentation;
        String responsive = state.layout;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Utils.verticalSpace(10.0),
            const CustomText(
              text: 'Other Features',
              fontSize: 14.0,
              color: primaryColor,
            ),
            OtherFeatureWidget(
              property: 'High Resolution',
              child: Checkbox(
                value: resolution == '0' ? false : true,
                activeColor: primaryColor,
                onChanged: (bool? val) {
                  resolution = resolution == '0' ? '1' : '0';
                  uploadBloc.highResolutionChange(resolution);
                },
              ),
            ),
            OtherFeatureWidget(
              property: 'Cross Browser',
              child: Checkbox(
                value: crossBrowser == '0' ? false : true,
                activeColor: primaryColor,
                onChanged: (bool? val) {
                  crossBrowser = crossBrowser == '0' ? '1' : '0';
                  uploadBloc.crossBrowserChange(crossBrowser);
                },
              ),
            ),
            OtherFeatureWidget(
              property: 'Documentation',
              child: Checkbox(
                value: documentation == '0' ? false : true,
                activeColor: primaryColor,
                onChanged: (bool? val) {
                  documentation = documentation == '0' ? '1' : '0';
                  uploadBloc.documentationChange(documentation);
                },
              ),
            ),
            OtherFeatureWidget(
              property: 'Responsive',
              child: Checkbox(
                value: responsive == '0' ? false : true,
                activeColor: primaryColor,
                onChanged: (bool? val) {
                  responsive = responsive == '0' ? '1' : '0';
                  uploadBloc.layoutChange(responsive);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class OtherFeatureWidget extends StatelessWidget {
  const OtherFeatureWidget(
      {super.key, required this.child, required this.property});

  final String property;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        child,
        Padding(
          padding: EdgeInsets.only(bottom: Utils.vPadding(size: 5.0)),
          child: CustomText(
            text: property,
            fontSize: 14.0,
            color: blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

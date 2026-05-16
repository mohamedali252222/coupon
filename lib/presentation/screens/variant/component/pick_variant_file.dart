import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/variant/variant_cubit.dart';
import '../../../../logic/cubit/variant/variant_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';

class PickVariantFile extends StatelessWidget {
  const PickVariantFile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final variantCubit = context.read<VariantCubit>();
    return BlocBuilder<VariantCubit, VariantStateModel>(
      builder: (context, state) {
        final fileName = state.fileName.split('/').last;
        final validate = state.variantState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Utils.vSize(size.height * 0.08),
              padding:
                  EdgeInsets.symmetric(horizontal: Utils.hPadding(size: 12.0)),
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      final file = await Utils.pickSingleFile();
                      debugPrint('picked-filed $file');
                      variantCubit.changeFileName(file ?? '');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      elevation: const MaterialStatePropertyAll(0.0),
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: const MaterialStatePropertyAll(transparent),
                    ),
                    child: const CustomText(
                      text: 'Choose File',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Utils.horizontalSpace(10.0),
                  Expanded(
                    child: CustomText(
                        text: fileName.isNotEmpty
                            ? fileName
                            : 'No File Selected'),
                  ),
                ],
              ),
            ),
            if (validate is VariantFormError) ...[
              if (validate.errors.fileName.isNotEmpty)
                ErrorText(text: validate.errors.fileName.first),
            ]
          ],
        );
      },
    );
  }
}

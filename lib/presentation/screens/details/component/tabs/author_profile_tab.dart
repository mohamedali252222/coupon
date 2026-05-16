import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/data_provider/remote_url.dart';
import '../../../../../data/models/home/product/author_model.dart';
import '../../../../../logic/cubit/details/details_cubit.dart';
import '../../../../../logic/cubit/language_code_state.dart';
import '../../../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../../../routes/routes_name.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/error_text.dart';
import '../../../../widget/loading_widget.dart';
import '../../../../widget/primary_button.dart';

class AuthorProfileTab extends StatelessWidget {
  const AuthorProfileTab({super.key, required this.author});

  final AuthorModel author;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final settingCubit =
        context.read<WebsiteSetupCubit>().setting!.setting!.defaultAvatar;
    final authorImage = author.image.isNotEmpty
        ? RemoteUrls.imageUrl(author.image)
        : RemoteUrls.imageUrl(settingCubit);
    return Container(
      padding: Utils.symmetric(v: 20.0),
      //margin: Utils.symmetric(),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: Utils.borderRadius(),
          boxShadow: const [
            BoxShadow(
              color: Color(0x28000000),
              blurRadius: 84,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomText(
            text: 'Author Profile',
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
          Container(
            height: 1.0,
            margin: Utils.symmetric(v: 8.0, h: 0.0),
            color: borderColor2,
          ),
          Container(
            width: size.width * 0.14,
            height: Utils.vSize(60.0),
            margin: Utils.only(bottom: 10.0),
            child: ClipRRect(
              borderRadius: Utils.borderRadius(r: 50.0),
              child: CustomImage(
                path: authorImage,
                // path: KImages.userPicture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomText(
            text: author.name,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: blackColor,
          ),
          Utils.verticalSpace(5.0),
          CustomText(
            text: Utils.formatDate(author.createdAt),
            fontSize: 14.0,
            color: grayColor,
          ),
          // Container(
          //   padding: Utils.symmetric(v: 20.0),
          //   margin: Utils.symmetric(v: 15.0, h: 0.0).copyWith(bottom: 20.0),
          //   decoration: BoxDecoration(
          //     color: scaffoldBgColor,
          //     borderRadius: Utils.borderRadius(),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       _productCount('85', 'Product'),
          //       Container(
          //         height: Utils.vSize(50.0),
          //         width: 1.0,
          //         color: const Color(0xFFDCDCDC),
          //       ),
          //       _productCount('255', 'Sales'),
          //     ],
          //   ),
          // ),
          Utils.verticalSpace(15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                    text: 'See Profile',
                    borderRadiusSize: 6.0,
                    onPressed: () => Navigator.pushNamed(
                        context, RouteNames.overviewScreen)),
              ),
              Utils.horizontalSpace(12.0),
              Expanded(
                child: PrimaryButton(
                    text: 'Send Message',
                    borderRadiusSize: 6.0,
                    onPressed: () => sendMessageToAuthor(context)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future sendMessageToAuthor(BuildContext context) async {
    final messageController = TextEditingController();
    Utils.showCustomDialog(
      context,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.hPadding(size: 16.0), vertical: Utils.vPadding()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  const Spacer(),
                const CustomText(
                  text: 'Send Message',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.clear, color: redColor))
              ],
            ),
            Utils.verticalSpace(14.0),
            BlocBuilder<DetailsCubit, LanguageCodeState>(
              builder: (context, state) {
                final message = state.detailsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'write your message..',
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                    ),
                    if (message is DetailsFormError) ...[
                      if (message.errors.message.isNotEmpty)
                        ErrorText(text: message.errors.message.first),
                    ]
                  ],
                );
              },
            ),
            Utils.verticalSpace(14.0),
            BlocConsumer<DetailsCubit, LanguageCodeState>(
              listener: (context, state) {
                final message = state.detailsState;
                if (message is PostCommentError) {
                  Navigator.of(context).pop();
                  Utils.errorSnackBar(context, message.message);
                } else if (message is DetailsSendMessageLoaded) {
                  Navigator.pop(context);
                  Utils.showSnackBar(context, message.message);
                  messageController.clear();
                }
              },
              builder: (context, state) {
                final message = state.detailsState;
                if (message is DetailsSendMessageLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Send',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    final body = {
                      'email': author.email,
                      'message': messageController.text
                    };
                    context.read<DetailsCubit>().sendMessageToAuthor(body);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _productCount(String count, String text) {
    return Column(
      children: [
        CustomText(
          text: count,
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
        ),
        CustomText(
          text: text,
          fontSize: 20.0,
          color: grayColor,
        ),
      ],
    );
  }
}

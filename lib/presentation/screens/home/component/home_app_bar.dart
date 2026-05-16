import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/setting/currencies_model.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/currency/currency_cubit.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/cart_badge.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import 'home_dropdown_button.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? image;

  String? name;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final settingCubit = context.read<WebsiteSetupCubit>();
    final profileCubit = context.read<ProfileCubit>();
    final user = loginBloc.userInformation!.user!;
    // print("image url ${RemoteUrls.imageUrl(user.image)}");
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: Utils.vSize(70.0),
      pinned: true,
      title: BlocConsumer<ProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final profile = state.profileState;
          if (profile is ProfileStateUpdated) {
            debugPrint('profile-updated');
            profileCubit.getUserProfile();
          }
        },
        builder: (context, state) {
          if (profileCubit.userModel != null) {
            image = profileCubit.userModel!.image.isNotEmpty
                ? RemoteUrls.imageUrl(profileCubit.userModel!.image)
                : RemoteUrls.imageUrl(
                    settingCubit.setting!.setting!.defaultAvatar);
            name = profileCubit.userModel!.name;
          } else {
            image = user.image.isNotEmpty
                ? RemoteUrls.imageUrl(user.image)
                : RemoteUrls.imageUrl(
                    settingCubit.setting!.setting!.defaultAvatar);
            name = user.name;
          }
          debugPrint('profile-state-changes');
          //final profile = state.profileState;
          return Container(
            width: double.infinity,
            padding: Utils.only(top: 16.0, bottom: 10.0),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CustomText(
                //   text: 'Hello, $name',
                //   fontSize: 14.0,
                //   fontWeight: FontWeight.w500,
                // ),
                //const CurrenciesWidget(),
                const HomeDropdownButton(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CartBadge(),
                    GestureDetector(
                      onTap: () {
                        if (loginBloc.userInformation == null) {
                          Utils.showSnackBar(context, 'Login first');
                        } else {
                          if (profileCubit.userModel != null) {
                            Navigator.pushNamed(
                                context, RouteNames.updateProfileScreen,
                                arguments: profileCubit.userModel!);
                          } else {

                            Utils.showSnackBar(context, 'Your session expired');
                          }
                        }
                      },
                      child: Container(
                        height: Utils.vSize(52.0),
                        width: Utils.vSize(52.0),
                        margin: Utils.only(left: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: blueGrayColor, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(r: 50.0),
                          child: CustomImage(
                            // path: KImages.userPicture,
                            path: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CurrenciesWidget extends StatefulWidget {
  const CurrenciesWidget({super.key});

  @override
  State<CurrenciesWidget> createState() => _CurrenciesWidgetState();
}

class _CurrenciesWidgetState extends State<CurrenciesWidget> {
  late CurrenciesModel _demoModel;
  late CurrencyCubit cCubit;

  @override
  void initState() {
    _initCurrencies();
    super.initState();
  }

  _initCurrencies() {
    final appSetting = context.read<WebsiteSetupCubit>().setting!.currencies;
    cCubit = context.read<CurrencyCubit>();
    if (appSetting!.isNotEmpty) {
      for (int i = 0; i < appSetting.length; i++) {
        final item = appSetting[i];

        if (item.isDefault.toLowerCase() == 'yes' && item.status == 1) {
          _demoModel = item;
          cCubit.addNewCurrency(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<WebsiteSetupCubit>();
    if (appSetting.setting != null &&
        appSetting.setting!.currencies!.isNotEmpty) {
      return Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: DropdownButtonFormField<CurrenciesModel>(
                  value: _demoModel,
                  hint: const Text('Currencies'),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onTap: () async {
                    Utils.closeKeyBoard(context);
                  },
                  onChanged: (value) {
                    if (value == null) return;
                    cCubit.state.currencies.clear();
                    cCubit.addNewCurrency(value);
                    debugPrint('values $value');
                  },
                  isDense: true,
                  isExpanded: true,
                  items: appSetting.setting!.currencies!.isNotEmpty
                      ? appSetting.setting!.currencies!
                          .map<DropdownMenuItem<CurrenciesModel>>(
                              (CurrenciesModel value) {
                          return DropdownMenuItem<CurrenciesModel>(
                              value: value,
                              child: Text(
                                value.currencyName,
                                style: GoogleFonts.inter(
                                    fontSize: 16.0, color: blackColor),
                              ));
                        }).toList()
                      : []),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

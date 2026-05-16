import 'package:flutter/material.dart';

import '../../../data/models/edit/edit_product_model.dart';
import '../../../logic/cubit/update/update_cubit.dart';
import '../../../logic/cubit/update/update_state_model.dart';
import '../../../state_packages_name.dart';
import '../../routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';
import '../../widget/product_app_bar.dart';
import '../authentication/component/custom_authentication_widget.dart';
import 'component/update_product_form.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.id});

  final String id;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  void initState() {
    context.read<UpdateCubit>().getEditProduct(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('product-id ${widget.id}');
    final size = MediaQuery.sizeOf(context);
    final updateCubit = context.read<UpdateCubit>();
    final dashboardCubit = context.read<DashboardCubit>();
    final isScript = updateCubit.state.productType == 'script';
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: CustomAuthenticationWidget(
        height: size.height * 0.16,
        isShowBackButton: false,
        topChild: UploadProductAppBar(
            title: 'Update Product',
            isVariantProduct: isScript ? false : true,
            child: BlocBuilder<UpdateCubit, UpdateStateModel>(
              builder: (context, state) {
                final update = state.updateState;
                if (update is UpdateEditProductLoading) {
                  return const SizedBox.shrink();
                } else if (update is UpdateEditProductLoaded) {
                  return _variantButton(update.editProduct);
                }
                if (updateCubit.editProduct != null) {
                  return _variantButton(updateCubit.editProduct!);
                } else {
                  return const SizedBox.shrink();
                }
              },
            )),
        child: BlocConsumer<UpdateCubit, UpdateStateModel>(
          listener: (context, state) {
            final editState = state.updateState;
            if (editState is UpdateEditProductError) {
              if (editState.statusCode == 503 ||
                  updateCubit.editProduct == null) {
                updateCubit.getEditProduct(widget.id);
              }
            } else {
              if (editState is UpdateEditProductUpdating) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (editState is UpdateProductError) {
                  Utils.errorSnackBar(context, editState.message);
                } else if (editState is UpdateEditProductUpdated) {
                  Utils.showSnackBar(context, editState.message);
                  updateCubit.getEditProduct(widget.id);
                  dashboardCubit.getUserPortfolio();
                }
              }
            }
          },
          builder: (context, state) {
            final editState = state.updateState;
            if (editState is UpdateEditProductLoading) {
              return const LoadingWidget();
            } else if (editState is UpdateEditProductError) {
              if (editState.statusCode == 503) {
                if (updateCubit.editProduct != null) {
                  return UpdateProductForm(product: updateCubit.editProduct!);
                }
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
              return FetchErrorText(text: editState.message);
            } else if (editState is UpdateEditProductLoaded) {
              return UpdateProductForm(product: editState.editProduct);
            }
            if (updateCubit.editProduct != null) {
              return UpdateProductForm(product: updateCubit.editProduct!);
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<UpdateCubit, UpdateStateModel>(
        builder: (context, state) {
          final update = state.updateState;
          if (update is UpdateEditProductLoading) {
            return const SizedBox.shrink();
          } else if (update is UpdateEditProductLoaded) {
            return Container(
              padding: Utils.symmetric(v: 20.0),
              child: PrimaryButton(
                  text: 'Upload Product',
                  onPressed: () {
                    Utils.closeDialog(context);
                    updateCubit.updateProduct(widget.id);
                  }),
            );
          }
          if (updateCubit.editProduct != null) {
            return Container(
              padding: Utils.symmetric(v: 20.0),
              child: PrimaryButton(
                  text: 'Upload Product',
                  onPressed: () {
                    Utils.closeDialog(context);
                    updateCubit.updateProduct(widget.id);
                  }),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _variantButton(EditProductModel product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteNames.variantScreen,
          arguments: product),
      child: Container(
        padding: Utils.symmetric(h: 12.0, v: 12.0),
        margin: Utils.only(left: 20.0),
        decoration: BoxDecoration(
          borderRadius: Utils.borderRadius(r: 6.0),
          gradient: const LinearGradient(
            begin: Alignment(0.53, -0.85),
            end: Alignment(-0.53, 0.85),
            colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
          ),
        ),
        child: const CustomText(
          text: 'All Variant',
          fontSize: 12.0,
        ),
      ),
    );
  }
}

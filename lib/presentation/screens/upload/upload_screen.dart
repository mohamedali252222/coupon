import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/upload_product/upload_product_bloc.dart';
import '../../../logic/bloc/upload_product/upload_product_state_model.dart';
import '../../utils/utils.dart';
import '../../widget/primary_button.dart';
import '../../widget/product_app_bar.dart';
import '../authentication/component/custom_authentication_widget.dart';
import 'component/add_product_variant_dialog.dart';
import 'component/upload_form.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final uploadBloc = context.read<UploadProductBloc>();
    print('product-type ${uploadBloc.state.productType}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: BlocListener<UploadProductBloc, UploadProductStateModel>(
        listener: (context, state) {
          final upload = state.uploadProductState;
          if (upload is UploadProductLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (upload is UploadProductError) {
              Utils.errorSnackBar(context, upload.message);
            } else if (upload is UploadProductUploaded) {
              Utils.showSnackBar(context, upload.message);
              // if (isScript) {
              //   Navigator.of(context).pop(true);
              // } else {
              //   //final productId = editProduct!.product!.id.toString();
              //   print('edit-product-id ${editProduct!.product!.id.toString()}');
              //   // Navigator.pushNamed(context, RouteNames.updateProductScreen,
              //   //     arguments: editProduct.product!.id.toString());
              // }
              //Navigator.of(context).pop(true);
              if (uploadBloc.state.productType != 'script') {
                debugPrint(
                    'this is not script product and have to add variant');
                showDialog(
                  context: context,
                  builder: (context) => const AddProductVariantDialog(),
                );
              } else {
                debugPrint('this is script product');
                Navigator.of(context).pop();
              }
              uploadBloc.add(const UploadProductClearFormEvent());
            }
          }
        },
        child: CustomAuthenticationWidget(
          height: size.height * 0.16,
          isShowBackButton: false,
          topChild: const UploadProductAppBar(title: 'Upload Product'),
          child: const UploadForm(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
            text: 'Upload Product',
            onPressed: () {
              Utils.closeDialog(context);
              uploadBloc
                  .add(UploadProductSubmitEvent(uploadBloc.state.productType));
            }),
      ),
    );
  }
}

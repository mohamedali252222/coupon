import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/wishlist/wishlist_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    Key? key,
    required this.productId,
    this.isBg = true,
  }) : super(key: key);
  final int productId;
  final bool isBg;

  @override
  State<FavouriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavouriteButton> {
  late Set<WishlistModel> wishItem;

  @override
  void initState() {
    super.initState();
    wishItem = <WishlistModel>{};
    loadWishItems();
  }

  bool isFav = false;

  loadWishItems() {
    final wishListItems = context.read<WishlistCubit>().wishList;
    final i = wishListItems
        .where((element) => element.id == widget.productId)
        .toSet();
    debugPrint("Wishlist item: $i");
    if (i.isNotEmpty) {
      setState(() {
        isFav = true;
        wishItem = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('wishItem-from-favourite $wishItem');
    // bool isFav = false;
    return BlocListener<WishlistCubit, LanguageCodeState>(
        listener: (context, state) {
      final wishlist = state.wishlistState;
      if (wishlist is WishlistLoading) {
        // Utils.loadingDialog(context);
      } else {
        // Utils.closeDialog(context);
        if (wishlist is WishlistError) {
          Utils.errorSnackBar(context, wishlist.message);
        } else if (wishlist is WishListStateSuccess) {
          Utils.showSnackBar(context, wishlist.message);
        } else if (wishlist is WishlistLoaded) {
          wishItem = wishlist.wishListData
              .where((element) => element.id == widget.productId)
              .toSet();
        }
      }
    }, child: StatefulBuilder(
      builder: (context, StateSetter setState) {
        return InkWell(
          onTap: () async {
            if (isFav) {
              if (wishItem.isNotEmpty) {
                final r = await context
                    .read<WishlistCubit>()
                    .deleteWishItem(wishItem.first.id.toString());
                r.fold(
                  (failure) {
                    Utils.showSnackBar(context, failure.message);
                  },
                  (success) {
                    Utils.showSnackBar(context, success);
                  },
                );
              } else {
                Utils.showSnackBar(context, "Something went wrong");
              }
            } else {
              context
                  .read<WishlistCubit>()
                  .addToWish(widget.productId.toString());
            }
            setState(() => isFav = !isFav);
          },
          child: CircleAvatar(
            maxRadius: 18.0,
            backgroundColor: primaryColor.withOpacity(0.5),
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: whiteColor,
            ),
          ),
        );
      },
    ));
  }
}

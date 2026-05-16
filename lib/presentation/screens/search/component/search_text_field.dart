import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/search/search_bloc.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';

class SearchTextField extends StatelessWidget implements PreferredSizeWidget {
  const SearchTextField({Key? key, required this.child}) : super(key: key);
  final Widget child;
  final double height = 100.0;

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: transparent,
      toolbarHeight: height,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Utils.vPadding(size: 15.0),
                right: Utils.hPadding(size: 15.0)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                print(
                    'back button presses with length ${searchBloc.property.length}');
                searchBloc.property.clear();
              },
              child: CircleAvatar(
                backgroundColor: primaryColor,
                minRadius: 18.0,
                child: Padding(
                  padding: EdgeInsets.only(left: Utils.hPadding(size: 0.0)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 22.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Utils.vSize(height));
}

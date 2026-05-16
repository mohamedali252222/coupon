import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.color = primaryColor}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}

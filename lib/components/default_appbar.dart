import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

Widget defaultAppBar() {
  return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      elevation: 5.0,
      title: Image.asset(
        "assets/images/logoclinicalaluz.png",
        fit: BoxFit.contain,
        height: getProportionateScreenHeight(35),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
            onPressed: () {})
      ]);
}

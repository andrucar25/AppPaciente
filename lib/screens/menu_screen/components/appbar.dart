import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

Widget appBar() {
  return SizedBox(
    height: AppBar().preferredSize.height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Container(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Image.asset(
                "assets/images/logoclinicalaluz.png",
                fit: BoxFit.contain,
                height: getProportionateScreenHeight(35),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Container(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
            color: Colors.white,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.search,
                  size: AppBar().preferredSize.height - 30,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  //TODO: Llamar al metodo de buscar
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

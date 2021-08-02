import 'package:applaluz/utils/config.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

recetaMedica(String receta) {
  if (receta == null) {
    return Row(
      children: [
        Icon(
          Icons.hourglass_empty,
          color: kPrimaryColor,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Aún no cuentas con una receta',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  } else {
    return OutlineButton(
        onPressed: () {
          launchInBrowser('https://$urlApi/$receta');
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        highlightColor: Colors.grey[100],
        borderSide: BorderSide(color: kTextColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.list_alt_sharp,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Text(
                        receta.substring(8),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            color: kTextColor),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 40.0, // you can adjust the width as you need
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                      size: 25.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

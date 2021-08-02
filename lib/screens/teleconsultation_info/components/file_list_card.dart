import 'package:applaluz/constants.dart';
import 'package:applaluz/models/ArchivoTeleconsulta.dart';
import 'package:applaluz/utils/config.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';

Widget fileListCard(ArchivoTeleconsulta object) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: OutlineButton(
        onPressed: () {
          launchInBrowser('https://$urlApi/${object.archivo}');
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
                        object.archivo.substring(9),
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
        )),
  );
}

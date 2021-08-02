import 'package:flutter/material.dart';

import '../../../constants.dart';

noFiles() {
  return Container(
    height: 120.0,
    child: Row(
      children: [
        Icon(
          Icons.file_present,
          color: kPrimaryColor,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Aún no cuentas con archivos adjuntos',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

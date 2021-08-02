import 'package:applaluz/models/ArchivoTeleconsulta.dart';
import 'package:flutter/material.dart';

import 'file_list_card.dart';
import 'no_files.dart';

Widget fileListSection(List<ArchivoTeleconsulta> fileList) {
  if (fileList.length == 0) return noFiles();
  return ListView.builder(
    itemCount: fileList.length,
    itemBuilder: (_, index) => fileListCard(fileList[index]),
  );
}

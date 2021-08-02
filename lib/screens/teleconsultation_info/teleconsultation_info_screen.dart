import 'dart:io';

import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/constants.dart';
import 'package:applaluz/models/ArchivoTeleconsulta.dart';
import 'package:applaluz/models/Teleconsulta.dart';
import 'package:applaluz/providers/teleconsulta_provider.dart';
import 'package:applaluz/screens/teleconsultation_info/components/files_list_section.dart';
import 'package:applaluz/screens/teleconsultation_info/components/no_files.dart';
import 'package:applaluz/screens/teleconsultation_info/components/receta_section.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TeleconsultationInfoScreen extends StatefulWidget {
  static String routeName = "/teleconsultation_info_screen";

  @override
  _TeleconsultationInfoScreenState createState() =>
      _TeleconsultationInfoScreenState();
}

class _TeleconsultationInfoScreenState
    extends State<TeleconsultationInfoScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  File selectedfile;
  String progress;

  @override
  Widget build(BuildContext context) {
    Teleconsulta teleconsulta = ModalRoute.of(context).settings.arguments;
    final provider = TeleconsultaProvider();
    Future<void> _uploadFile(BuildContext context) async {
      Dialogs.showLoadingDialog(context, _keyLoader, 'Subiendo Archivo');
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path);

        String resp = await provider.uploadFile(
            teleconsulta.idTeleconsulta, file, teleconsulta.idMedico);
        if (resp == "success") {
          Navigator.pushReplacementNamed(
              context, TeleconsultationInfoScreen.routeName,
              arguments: teleconsulta);
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          showAlertWithTitle(
              context,
              'No pudimos subir tu archivo, por favor intentalo mas tarde',
              'Error');
        }
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        showAlertWithTitle(
            context,
            'Por favor selecciona un archivo para subir',
            'No se encontro un archivo');
      }
    }

    List<Widget> filesSection(List<ArchivoTeleconsulta> data) {
      String receta =
          (data.isEmpty) ? teleconsulta.receta : data[0].teleconsulta.receta;
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Archivos Adjuntos',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  fontWeight: FontWeight.w900),
            ),
            Icon(
              Icons.file_copy,
              color: kPrimaryColor,
              size: 20.0,
            ),
          ],
        ),
        Divider(
          color: kPrimaryColor,
          thickness: 0.3,
        ),
        Container(
          height: 120.0,
          child: fileListSection(data),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () {
            _uploadFile(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file,
                color: Colors.white,
              ),
              Text('Subir Archivo'),
            ],
          ),
          style: TextButton.styleFrom(
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            primary: Colors.white,
            elevation: 3.0,
            backgroundColor: kPrimaryColor,
            onSurface: Colors.grey,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Receta Medica',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  fontWeight: FontWeight.w900),
            ),
            Icon(
              Icons.description,
              color: kPrimaryColor,
              size: 20.0,
            ),
          ],
        ),
        Divider(
          color: kPrimaryColor,
          thickness: 0.3,
        ),
        recetaMedica(receta),
      ];
    }

    return Scaffold(
        appBar: defaultAppBar(),
        body: Container(
          child: Stack(children: [
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/backinfoteleconsulta.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              height: 280,
            )),
            Container(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('INFORMACIÓN',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 12.0,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300)),
                  Text(
                    'TELECONSULTA',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 12.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            teleconsulta.foto,
                            height: 200.0,
                            width: 140.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Dr. ${teleconsulta.nombresMedico} ${teleconsulta.apellidosMedico}',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            teleconsulta.especialidad,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                teleconsulta.fecha,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                teleconsulta.hora,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FutureBuilder(
                    future: provider
                        .getArchivosTeleconsulta(teleconsulta.idTeleconsulta),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ArchivoTeleconsulta>> snapshot) {
                      if (snapshot.data == null)
                        return Container(
                          height: 300.0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return Column(
                        children: filesSection(snapshot.data),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

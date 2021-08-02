import 'dart:io';
import 'package:applaluz/constants.dart';
import 'package:applaluz/providers/reclamo_provider.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
import '../../../size_config.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:file_picker/file_picker.dart';

class SuggestionForm extends StatefulWidget {
  @override
  _SuggestionForm createState() => _SuggestionForm();
}

class _SuggestionForm extends State<SuggestionForm> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int tipo = 1;
  String descripcion = "";
  File selectedfile;
  String texto = "Subir archivo";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(25)),
        child: Form(
            child: Column(
          children: <Widget>[
            Text(
              "¡Escríbenos!",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(50)),
            rbtn("Sugerencia/Comentario", 1),
            rbtn("Queja", 2),
            rbtn("Reclamación", 3),
            SizedBox(height: getProportionateScreenHeight(30)),
            descriptionField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Text(
              "Opcionalmente puedes adjuntar una imagen, video o archivo",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            uploadFileButton(),
            SizedBox(height: getProportionateScreenHeight(60)),
            Container(
              alignment: Alignment.center,
              child: DefaultButton(
                text: "Enviar",
                press: () {
                  if (selectedfile == null) {
                    storeReclamo(context);
                  } else {
                    storeReclamoArchivo(context);
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  TextField descriptionField() {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ingresa tu sugerencia, queja o reclamación'),
      onChanged: (value) {
        descripcion = value;
      },
    );
  }

  Widget rbtn(String texto, int valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: kPrimaryColor,
          value: valor,
          groupValue: tipo,
          onChanged: (val) {
            tipo = val;
            setState(() {});
          },
        ),
        Text(
          texto,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: getProportionateScreenWidth(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  TextButton uploadFileButton() {
    return TextButton(
      onPressed: () {
        _uploadFile(context);
      },
      child: Container(
        width: getProportionateScreenWidth(120.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              color: Colors.white,
            ),
            Text(texto),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        primary: Colors.white,
        elevation: 3.0,
        backgroundColor: kPrimaryColor,
        onSurface: Colors.grey,
      ),
    );
  }

  Future<void> _uploadFile(BuildContext context) async {
    //Dialogs.showLoadingDialog(context, _keyLoader, 'Subiendo Archivo');
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      selectedfile = file;
      setState(() {
        texto = "Archivo subido";
      });
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlertWithTitle(context, 'Por favor selecciona un archivo para subir',
          'No se encontro un archivo');
    }
  }

  Future<void> storeReclamo(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Guardando');
    ReclamoProvider reclamoProvider = new ReclamoProvider();
    String resp = await reclamoProvider.postReclamo(tipo, descripcion);

    if (resp == "Registro exitoso") {
      showAlertReclamoExito(context,"Estaremos leyendo pronto, ¡muchas gracias!");
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlertReclamo(context, resp);
    }
  }

  Future<void> storeReclamoArchivo(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Guardando');
    ReclamoProvider reclamoProvider = new ReclamoProvider();
    String resp = await reclamoProvider.postReclamoArchivo(
        tipo, descripcion, selectedfile);

    if (resp == "success") {
      showAlertReclamoExito(context, "Estaremos leyendo pronto, ¡muchas gracias!");
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlertReclamo(context, resp);
    }
  }
}

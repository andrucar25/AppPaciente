import 'dart:math';
import 'package:applaluz/constants.dart';
import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/providers/commentary_provider.dart';
import 'package:applaluz/screens/home_screen/home_screen.dart';
import 'package:applaluz/screens/menu_screen/menu_screen.dart';
import 'package:applaluz/screens/payment_chat_screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../size_config.dart';

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

void showModalMessage(
    BuildContext context, String message, IconData icon, String title) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 40.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                ButtonTheme(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // background
                      onPrimary: Colors.grey, // foreground
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('Regresar'),
                      ],
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

int getMonthNumber(String name) {
  switch (name) {
    case 'Enero':
      return 1;
      break;
    case 'Febrero':
      return 2;
      break;
    case 'Marzo':
      return 3;
      break;
    case 'Abril':
      return 4;
      break;
    case 'Mayo':
      return 5;
      break;
    case 'Junio':
      return 6;
      break;
    case 'Julio':
      return 7;
      break;
    case 'Agosto':
      return 8;
      break;
    case 'Septiembre':
      return 9;
      break;
    case 'Octubre':
      return 10;
      break;
    case 'Noviembre':
      return 11;
      break;
    case 'Diciembre':
      return 12;
      break;
    default:
      return 1;
  }
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
    );
  } else {
    throw 'Could not launch $url';
  }
}

String getEspecialidadName(int index) {
  switch (index) {
    case 1:
      return 'Reumatologia';
      break;
    case 2:
      return 'Cardiologia';
      break;
    case 3:
      return 'Fisiatria';
      break;
    case 4:
      return 'Neumologia';
      break;
    case 5:
      return 'Oftalmologia';
      break;
    case 6:
      return 'Gastroenterologia';
      break;
    default:
      return 'Sin nombre';
  }
}

String weekday(int day) {
  switch (day) {
    case 1:
      return 'Lun';
      break;
    case 2:
      return 'Ma';
      break;
    case 3:
      return 'Mie';
      break;
    case 4:
      return 'Jue';
      break;
    case 5:
      return 'Vie';
      break;
    case 6:
      return 'Sab';
      break;
    case 7:
      return 'Dom';
      break;
    default:
      return 'Domingo';
      break;
  }
}

void showAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Informacion incorrecta',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertWithTitle(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            title,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  key: key,
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey[600]),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

void showAlertCulqiTarjeta(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Error de validación',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 300.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertPago(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Error en la transacción',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertTeleconsultaPendiente(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'No hay teleconsulta aún!',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertLaboratorio(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'No hay resultados aún!',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertReclamo(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Error guardando datos',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.error,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: kPrimaryColor,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.check),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]),
        ),
      );
    },
  );
}

void showAlertReclamoExito(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Registro correcto',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 200.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.article,
              size: 70.0,
              color: Colors.green,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message, //"Estaremos leyendo pronto, muchas gracias",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: Colors.white,
                color: Colors.green,
                label: Text(
                  'Aceptar',
                ),
                icon: Icon(Icons.done),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, MenuScreen.routeName),
              ),
            )
          ]),
        ),
      );
    },
  );
}

//Modal Comentar y puntuar
void showCommentaryModal(BuildContext context, int idMedico) {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String descripcion = '';
  double puntuacion = 0;
  Future<void> _storeCommentary() async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Guardando comentario');

    CommentaryProvider commentaryProvider = new CommentaryProvider();
    String resp = await commentaryProvider.storeCommentary(
        puntuacion, descripcion, idMedico);
    if (resp == "Comentario guardado") {
      showAlertReclamoExito(context, "¡Gracias por darnos tu opinión!");
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlertReclamo(context, resp);
    }
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Form(
                key: formKey,
                child: Container(
                  height: getProportionateScreenHeight(450.0),
                  width: getProportionateScreenWidth(300.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate,
                            size: getProportionateScreenHeight(40.0),
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10.0),
                          ),
                          Text(
                            'Calificar Médico',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: getProportionateScreenHeight(20.0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Calificacion",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(5.0)),
                          RatingBar.builder(
                            unratedColor: Colors.black,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: kPrimaryColor,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: kPrimaryColor,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: kPrimaryColor,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: kPrimaryColor,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: kPrimaryColor,
                                  );
                              }
                            },
                            itemCount: 5,
                            onRatingUpdate: (rating) {
                              puntuacion = rating;
                            },
                            initialRating: 0,
                            itemSize: 30.0,
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5.0)),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Describe la atención del médico',
                          counterText: '*Maximo de 300 caracteres',
                        ),
                        onChanged: (value) {
                          descripcion = value;
                        },
                        validator: (value) {
                          if (value.length > 300 || value.length == 0) {
                            return 'Ingrese un comentario menor de 300 caracteres';
                          } else {
                            return null;
                          }
                        },
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor, // background
                              onPrimary: Colors.grey, // foreground
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Guardar calificación',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _storeCommentary();
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

void showAlertChat(BuildContext context, String message, Medico medico) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Desbloquear Chat',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        ),
        content: Container(
          height: 270.0,
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.question_answer,
              size: 70.0,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              message,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'Desbloquear',
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, PaymentScreenChat.routeName,
                        arguments: medico),
                  ),
                ),
                SizedBox(
                  width: 130.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    color: kPrimaryColor,
                    child: Text(
                      'No, gracias',
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            )
          ]),
        ),
      );
    },
  );
}

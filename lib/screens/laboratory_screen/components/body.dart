import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/components/default_button.dart';
import 'package:applaluz/components/form_error.dart';
import 'package:applaluz/helper/areas.dart';
import 'package:applaluz/helper/areas_arguments.dart';
import 'package:applaluz/helper/keyboard.dart';
import 'package:applaluz/providers/laboratory_provider.dart';
import 'package:applaluz/screens/laboratory_confirmation_screen/laboratory_confirmation_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LaboratoryBody extends StatefulWidget {
  @override
  _LaboratoryBodyState createState() => _LaboratoryBodyState();
}

class _LaboratoryBodyState extends State<LaboratoryBody> {
  final _formKey = GlobalKey<FormState>();
  final laboratoryProvider = new LaboratoryProvider();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String cellphone;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    final int areaid = settings.arguments;
    final Areas area = Areas.areasList[areaid];
    return Container(
      child: Scaffold(
        appBar: defaultAppBar(),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(10),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30)),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      ColorFiltered(
                        child: Image.asset(
                          area.imagePath,
                          fit: BoxFit.contain,
                          height: getProportionateScreenHeight(90),
                        ),
                        colorFilter:
                            ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text('ÁREA DE',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: kTextColor,
                                    letterSpacing: 12.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              area.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Divider(
                    color: kSecondaryColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_pin,
                        size: 70.0,
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            area.responsable,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text('Responsable')
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.book,
                          color: kPrimaryColor,
                          size: 60.0,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'SEPARAR CITA',
                          style: TextStyle(
                            letterSpacing: 10.0,
                            fontSize: 20.0,
                            color: kPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: kPrimaryColor,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Coloca tu numero telefonico para poder separar tu cita, te mandaremos un codigo de confirmacion por mensaje de texto.',
                          style: TextStyle(
                            letterSpacing: 3.0,
                            fontSize: 13.0,
                            color: kSecondaryColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildCellphoneFormField(),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultIconButton(
                          icon: Icons.send,
                          text: "Enviar Codigo",
                          press: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // if all are valid then go to success screen
                              KeyboardUtil.hideKeyboard(context);
                              _storeLaboratory(area.responsable, cellphone,
                                  area.area, context);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _storeLaboratory(String responsable, String telefono, int area,
      BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Validando Datos');
    Map info = await laboratoryProvider.sendConfirmation(telefono);

    if (info['ok']) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      AreasArguments areasArguments = AreasArguments(
          info['number'].toString(), cellphone, responsable, area);
      //METODO DE NAVIGATOR QUE BORRA TODAS LAS RUTAS ANTERIORES Y MUESTRA UNA NUEVA
      Navigator.pushNamed(context, ConfirmationLaboratoryScreen.routeName,
          arguments: areasArguments);
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlert(context, info['message']);
    }
  }

  TextFormField buildCellphoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cellphone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Por favor ingresa un numero telefonico');
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(
              error: 'Por favor ingresa un numero valido (9 caracteres)');
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Por favor ingresa un numero telefonico');
          return "";
        } else if (value.length != 9) {
          addError(error: 'Por favor ingresa un numero valido');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Numero Telefonico",
        hintText: "Ingresa tu numero telefonico",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

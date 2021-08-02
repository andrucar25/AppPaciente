import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/components/default_button.dart';
import 'package:applaluz/components/form_error.dart';
import 'package:applaluz/helper/areas_arguments.dart';
import 'package:applaluz/helper/keyboard.dart';
import 'package:applaluz/providers/laboratory_provider.dart';
import 'package:applaluz/screens/laboratory_dni_screen/laboratory_dni_screen.dart';
import 'package:applaluz/screens/laboratory_success_screen/laboratory_success_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ConfirmationLaboratoryBody extends StatefulWidget {
  @override
  _ConfirmationLaboratoryBodyState createState() =>
      _ConfirmationLaboratoryBodyState();
}

class _ConfirmationLaboratoryBodyState
    extends State<ConfirmationLaboratoryBody> {
  final _formKey = GlobalKey<FormState>();
  final laboratoryProvider = new LaboratoryProvider();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String confirmationNumber;

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
    final AreasArguments areasArguments = settings.arguments;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: kPrimaryColor,
                          size: 60.0,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'CONFIRMACION DE CITA PARA LABORATORIO',
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
                          'Codigo de confirmacion enviado al: ${areasArguments.cellphone}',
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
                          text: "Validar Codigo",
                          press: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // if all are valid then go to success screen
                              KeyboardUtil.hideKeyboard(context);
                              _storeLaboratory(
                                  areasArguments, confirmationNumber, context);
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

  Future<void> _storeLaboratory(AreasArguments areasArguments, String number,
      BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Validando Datos');
    if (areasArguments.number == number) {
      await Future.delayed(Duration(seconds: 1));

      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      //METODO DE NAVIGATOR QUE BORRA TODAS LAS RUTAS ANTERIORES Y MUESTRA UNA NUEVA
      Navigator.pushReplacementNamed(context, DNILaboratoryScreen.routeName,
          arguments: areasArguments);
    } else {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlert(context, 'El codigo ingresado no es el correcto');
    }
  }

  TextFormField buildCellphoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => confirmationNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Por favor ingresa tu numero de confirmacion');
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(
              error: 'Por favor ingresa un numero valido (4 caracteres)');
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Por favor ingresa tu numero de confirmacion');
          return "";
        } else if (value.length != 4) {
          addError(error: 'Por favor ingresa un numero valido (4 caracteres)');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Codigo de confirmacion",
        hintText: "Ingresa tu codigo de confirmacion",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/components/default_button.dart';
import 'package:applaluz/components/form_error.dart';
import 'package:applaluz/helper/areas_arguments.dart';
import 'package:applaluz/helper/keyboard.dart';
import 'package:applaluz/providers/laboratory_provider.dart';
import 'package:applaluz/screens/laboratory_success_screen/laboratory_success_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class DniLaboratoryBody extends StatefulWidget {
  @override
  _ConfirmationLaboratoryBodyState createState() =>
      _ConfirmationLaboratoryBodyState();
}

class _ConfirmationLaboratoryBodyState extends State<DniLaboratoryBody> {
  final _formKey = GlobalKey<FormState>();
  final laboratoryProvider = new LaboratoryProvider();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String dni;
  bool billDataValidator = false;
  bool showReniecData = false;
  String responseReniecData = '';
  bool _isButtonDisabled = true;
  @override
  void initState() {
    _isButtonDisabled = true;
  }

  List<String> errors = [];

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
                          Icons.person,
                          color: kPrimaryColor,
                          size: 60.0,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'DNI DE CLIENTE PARA LABORATORIO',
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
                          'Codigo de confirmacion enviado via SMS a: ${areasArguments.cellphone}',
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
                        if (showReniecData)
                          ListTile(
                            title: Text(responseReniecData),
                            subtitle: Text('Nombres y Apellidos'),
                            trailing: Icon(Icons.text_snippet),
                          ),
                        SizedBox(
                          height: 10.0,
                        ),
                        buildCellphoneFormField(),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultIconButton(
                          icon: Icons.assignment_ind,
                          text: "Validar DNI",
                          press: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // if all are valid then go to success screen
                              KeyboardUtil.hideKeyboard(context);
                              _validate(context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: kPrimaryColor,
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    _storeLaboratory(areasArguments, context);
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Confirmar Cita',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Future<void> _storeLaboratory(
      AreasArguments areasArguments, BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Validando Datos');
    Map info = await laboratoryProvider.storeLaboratory(
        areasArguments.responsable,
        areasArguments.area,
        '$dni - $responseReniecData');
    if (info['ok']) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      //METODO DE NAVIGATOR QUE BORRA TODAS LAS RUTAS ANTERIORES Y MUESTRA UNA NUEVA
      Navigator.restorablePushNamedAndRemoveUntil(context,
          LaboratorySuccessScreen.routeName, (Route<dynamic> route) => false);
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlert(context, info['message']);
    }
  }

  Future<void> _validate(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Validando Datos');
    String response = await laboratoryProvider.getReniecData(dni);
    if (response != '') {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      setState(() {
        responseReniecData = response;
        showReniecData = true;
        billDataValidator = true;
        _isButtonDisabled = false;
        errors = [];
      });
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      setState(() {
        showReniecData = false;
        _isButtonDisabled = true;
      });
      showAlert(context, 'El DNI que ingreso no es valido');
    }
  }

  TextFormField buildCellphoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => dni = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Por favor ingresa el DNI del paciente');
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: 'Por favor ingresa un DNI valido (8 caracteres)');
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Por favor ingresa el DNI del paciente');
          return "";
        } else if (value.length != 8) {
          addError(error: 'Por favor ingresa un DNI valido (8 caracteres)');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "DNI del Paciente",
        hintText: "Ingresa el DNI del paciente",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

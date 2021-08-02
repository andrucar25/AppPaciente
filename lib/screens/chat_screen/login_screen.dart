import 'package:applaluz/helper/show_alert.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';
import 'package:applaluz/services/auth_service.dart';
import 'package:applaluz/services/socket_service.dart';
import 'package:applaluz/widgets/custom_input.dart';
import 'package:applaluz/widgets/labels.dart';
import 'package:applaluz/widgets/logo.dart';
import 'package:applaluz/widgets/button_login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Logo(
                      titulo: 'Chat La Luz',
                    ),
                    _Form(),
                    Labels(
                      ruta: 'register',
                      titulo: 'No tienes cuenta?',
                      subTitulo: 'Crea una ahora!',
                    ),
                  /*  SizedBox(
                  width: 140.0,
                  height: 40.0,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    color: Colors.red,
                    label: Text(
                      'Regresar',
                    ),
                    icon: Icon(Icons.arrow_back),
                    onPressed: () =>  Navigator.pushReplacementNamed(
                    context, MedicMenuScreen.routeName),
                  ),
                ),*/
                  /*  Text('Terminos y condiciones de uso',
                        style: TextStyle(fontWeight: FontWeight.w200))*/
                  ],
                ),
              )),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          ButtonLogin(
            text: 'Ingresar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'user');
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales');
                    }
                  },
          ),
        ],
      ),
    );
  }
}

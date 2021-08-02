import 'package:flutter/material.dart';
import 'package:applaluz/components/no_account_text.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Image.asset(
                  "assets/images/iconolaluz.png",
                  fit: BoxFit.contain,
                  height: getProportionateScreenHeight(80),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Bienvenido!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ingresa con tu correo y contraseña  \no registrate totalmente gratis!",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:applaluz/helper/hexcolors.dart';
import 'package:applaluz/size_config.dart';
import 'package:flutter/material.dart';

Color kPrimaryColor = HexColor("#cf1927");
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFCF1927), Color(0xFFFB4A58)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const String fontName = 'WorkSans';
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.grey[700],
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor ingresa un correo electronico";
const String kInvalidEmailError =
    "Por favor ingresa un correo electronico valido";
const String kPassNullError = "Por favor ingresa tu clave";
const String kShortPassError = "La clave es muy corta";
const String kMatchPassError = "Las claves no son iguales";
const String kNamelNullError = "Por favor ingresa tu nombre";
const String kPhoneNumberNullError = "Por favor ingresa tu numero telefonico";
const String kAddressNullError = "Por favor ingresa tu direccion";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

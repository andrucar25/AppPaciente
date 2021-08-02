import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/providers/chat_provider.dart';
import 'package:applaluz/providers/payment_provider.dart';
import 'package:applaluz/screens/chat_screen/main_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_culqi/flutter_culqi.dart';
import '../../../components/default_button.dart';
import '../../../size_config.dart';
import 'package:applaluz/components/custom_surfix_icon.dart';
import 'package:applaluz/screens/payment_screen/confirm_payment.dart';
import 'package:applaluz/utils/utils.dart';

final String _publicKey = 'pk_test_3edffebb23ebe3ce';

class PaymentFormChat extends StatefulWidget {
  @override
  _PaymentFormChat createState() => _PaymentFormChat();
}

class _PaymentFormChat extends State<PaymentFormChat> {
  GlobalKey<CulqiPaymentState> _key = GlobalKey();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String _cardNumber;
  String _email;
  String _cvv;
  int _month;
  int _year;
  final double _amount = 5500;
  String _token = '';

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    final Medico medico = settings.arguments;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(60)),
        child: Form(
            child: Column(
          children: <Widget>[
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
              "Paga Aquí!",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Ingresa tu tarjeta y datos para\ncompletar la transaccion y \ndesbloquear el chat",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(50)),
            cardNumberField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            monthField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            yearField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            cvvField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            emailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              alignment: Alignment.center,
              child: DefaultButton(
                text: "Pagar",
                press: () {
                  processToken(context, medico);
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

//Obtener el token
  Future<void> processToken(BuildContext context, Medico medico) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Validando Datos');

    CulqiCard card = CulqiCard(
      cardNumber: _cardNumber,
      cvv: _cvv,
      expirationMonth: _month,
      expirationYear: _year,
      email: _email,
    );

    CulqiTokenizer tokenizer = CulqiTokenizer(card);

    var result = await tokenizer.getToken(publicKey: _publicKey);
    if (result is CulqiToken) {
      setState(() {
        _token = result.token;
      });

      PaymentProvider paymentprovider = new PaymentProvider();
      String resp =
          await paymentprovider.postPaymentChat(_token, _email, _amount);
      if (resp == "Venta exitosa") {
        ChatProvider chatprovider = new ChatProvider();
        String resp = await chatprovider.storeChatMedico(medico.idMedico);
        if (resp == "Chat Guardado") {
          //Navigator.pushReplacementNamed(context, MainChat.routeName);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => new MainChat(),
            ),
          );
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          showAlertPago(context, resp);
        }
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        showAlertPago(context, resp);
      }
    } else if (result is CulqiError) {
      setState(() {
        _token = result.errorMessage;
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        showAlertCulqiTarjeta(context, result.errorMessage);
      });
    }
  }

  TextFormField cardNumberField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        _cardNumber = value;
      },
      decoration: InputDecoration(
        labelText: "Numero de tarjeta",
        hintText: "XXXX - XXXX - XXXX - XXXX",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField monthField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _month = int.parse(value);
      },
      decoration: InputDecoration(
        labelText: "Mes",
        hintText: "Ingrese el mes con 2 digitos",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField yearField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _year = int.parse(value);
      },
      decoration: InputDecoration(
        labelText: "Año",
        hintText: "Ingrese el año con 4 digitos",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField cvvField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _cvv = value;
      },
      decoration: InputDecoration(
        labelText: "CVV",
        hintText: "123",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        _email = value;
      },
      decoration: InputDecoration(
        labelText: "Correo electronico",
        hintText: "Ingresa tu correo electronico",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

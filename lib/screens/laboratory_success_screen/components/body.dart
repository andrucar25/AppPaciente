import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/components/default_button.dart';
import 'package:applaluz/helper/areas_arguments.dart';
import 'package:applaluz/screens/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LaboratorySuccessBody extends StatefulWidget {
  @override
  _LaboratoryBodyState createState() => _LaboratoryBodyState();
}

class _LaboratoryBodyState extends State<LaboratorySuccessBody> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    final AreasArguments areasArguments = settings.arguments;
    return Container(
      child: Scaffold(
        appBar: defaultAppBar(),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/backsplash.png"),
            fit: BoxFit.cover,
          )),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: kPrimaryColor,
                          size: 100.0,
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'TU CITA PARA LABORATORIO SE GUARDO CON EXITO!',
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
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Ahora podras encontrar tu ticket y resultados en la pantalla de inicio, apartado de historiales.',
                          style: TextStyle(
                            letterSpacing: 3.0,
                            fontSize: 18.0,
                            color: kSecondaryColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  DefaultIconButton(
                    text: 'Continuar',
                    icon: Icons.home,
                    press: () {
                      Navigator.restorablePushNamedAndRemoveUntil(
                          context,
                          MenuScreen.routeName,
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

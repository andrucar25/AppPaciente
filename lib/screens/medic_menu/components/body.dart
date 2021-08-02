import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/screens/medic_menu/list_medic_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:applaluz/constants.dart';

class MedicMenu extends StatefulWidget {
  @override
  _MedicMenuState createState() => _MedicMenuState();
}

class _MedicMenuState extends State<MedicMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: defaultAppBar(),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(50),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30)),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              MyMenu(
                  title: "Cardiología",
                  route: "assets/images/especialidades/cardio.png",
                  especialidad: 2),
              MyMenu(
                  title: "Fisiatría",
                  route: "assets/images/especialidades/fisio.png",
                  especialidad: 3),
              MyMenu(
                  title: "Neumología",
                  route: "assets/images/especialidades/neumo.png",
                  especialidad: 4),
              MyMenu(
                  title: "Oftalmología",
                  route: "assets/images/especialidades/oftal.png",
                  especialidad: 5),
              MyMenu(
                  title: "Reumatología",
                  route: "assets/images/especialidades/reuma.png",
                  especialidad: 1),
              MyMenu(
                  title: "Gastroenterología",
                  route: "assets/images/especialidades/gastro.png",
                  especialidad: 6),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.route, this.especialidad});

  final String title;
  final String route;
  final int especialidad;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: kPrimaryColor,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ListMedicScreen.routeName,
                arguments: especialidad);
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ColorFiltered(
                  child: Image.asset(
                    route,
                    fit: BoxFit.contain,
                    height: getProportionateScreenHeight(70),
                  ),
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),

                // Icon(icon, size:70.0),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(title,
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )),
    );
  }
}

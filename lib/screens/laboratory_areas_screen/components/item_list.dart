import 'package:applaluz/screens/laboratory_screen/laboratory_screen.dart';
import 'package:applaluz/screens/medic_menu/list_medic_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AreaItem extends StatelessWidget {
  AreaItem({this.title, this.route, this.area});

  final String title;
  final String route;
  final int area;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: kPrimaryColor,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, LaboratoryScreen.routeName,
                arguments: area);
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
                    textAlign: TextAlign.center,
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

import 'package:applaluz/constants.dart';
import 'package:applaluz/providers/paciente_provider.dart';
import 'package:applaluz/screens/asistente/asistente.dart';
import 'package:applaluz/screens/home_screen/home_screen.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';
import 'package:applaluz/screens/splash/splash_screen.dart';
import 'package:applaluz/screens/suggestion_screen/suggestion_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import '../../size_config.dart';
import 'components/menu_items.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = "/menu_screen";
  @override
  _DrawerScaleIconState createState() => _DrawerScaleIconState();
}

class _DrawerScaleIconState extends State<MenuScreen> {
  int selectedMenuItemId;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final pacientesProvider = new PacienteProvider();

  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[0].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // call it on your starting screen
    SizeConfig().init(context);
    return DrawerScaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 5.0,
          title: Image.asset(
            "assets/images/logoclinicalaluz.png",
            fit: BoxFit.contain,
            height: getProportionateScreenHeight(35),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, PaymentScreen.routeName);
                  Navigator.pushNamed(context, MedicMenuScreen.routeName);
                })
          ]),
      drawers: [
        SideDrawer(
          selectorColor: Colors.white70,
          percentage: 0.6,
          menu: menuWithIcon,
          animation: true,
          color: kPrimaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            if (itemId == 5) _logout(pacientesProvider, context);
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        )
      ],
      builder: (context, id) => IndexedStack(
        index: id,
        children: menu.items.map<Widget>((e) {
          switch (id) {
            case 0:
              {
                return HomeScreen();
              }
              break;

            case 1:
              {
                return HomeScreen();
              }
              break;
            case 2:
              {
                return HomeScreen();
              }
              break;
            case 3:
              {
                return HomeScreen();
              }
              break;
            case 4:
              {
                return SuggestionScreen();
              }
              break;

            default:
              {
                return HomeScreen();
              }
              break;
          }
        }).toList(),
      ),
    );
  }

  Future<void> _logout(PacienteProvider provider, BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader, 'Cerrando Sesion');
    bool response = await pacientesProvider.logout();
    if (response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, SplashScreen.routeName);
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showAlert(context, 'Ocurrio un error, Intentalo mas tarde');
    }
  }
}

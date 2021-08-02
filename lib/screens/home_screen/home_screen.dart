/*

* Screen de la vista inicial donde estan las noticias, listado de medicos y especialidad
* 

* @author Sigfredo Aponte Roldan

* @version 1.0 

*/
import 'package:applaluz/helper/medics.dart';
import 'package:applaluz/screens/asistente/asistente.dart';
import 'package:applaluz/screens/history_screen/history_screen.dart';
import 'package:applaluz/screens/laboratory_areas_screen/laboratory_areas_screen.dart';
import 'package:applaluz/screens/medic_screen/medic_screen.dart';
import 'package:applaluz/screens/pending_teleconsultation/pending_teleconsultation_screen.dart';
import 'package:applaluz/screens/teleconsultation_info/teleconsultation_info_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/category_list_view.dart';
import 'components/horizontal_place_item.dart';
import 'components/news_list.dart';
import 'components/title_view.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [];
    pageList.add(homeScreenSection(context));
    pageList.add(PendingTeleconsultationScreen());
    pageList.add(LaboratoryAreasScreen());
    pageList.add(HistoryScreen());
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
            activeColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Teleconsultas'),
            activeColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text(
              'Laboratorios',
            ),
            activeColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('Historiales'),
            activeColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

homeScreenSection(BuildContext context) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      heroTag: null,
      onPressed: () {
        Navigator.pushNamed(context, AsistantScreen.routeName);
      },
      backgroundColor: kPrimaryColor,
      child: Icon(Icons.chat),
    ),
    body: ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
        TitleView(
          titleTxt: 'Nuestro Staff',
          subTxt: 'Ver más',
          press: () {
            Navigator.pushNamed(context, MedicScreen.routeName);
          },
        ),
        buildHorizontalList(context),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: TitleView(
            titleTxt: 'Especialidades',
            subTxt: 'Ver más',
            press: () {
              Navigator.pushNamed(context, MedicMenuScreen.routeName);
            },
          ),
        ),
        CategoryListView(
          callBack: () {},
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: TitleView(
            titleTxt: 'Noticias',
            subTxt: 'Ver más',
            press: () {
              Navigator.pushNamed(
                  context, TeleconsultationInfoScreen.routeName);
            },
          ),
        ),
        newsList(),
      ],
    ),
  );
}

buildHorizontalList(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 10.0, left: 20.0),
    height: 250.0,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: medics == null ? 0.0 : medics.length,
      itemBuilder: (BuildContext context, int index) {
        Map medic = medics.reversed.toList()[index];
        return HorizontalPlaceItem(medic: medic);
      },
    ),
  );
}

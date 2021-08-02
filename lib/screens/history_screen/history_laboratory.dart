/*

* Screen para listar el historial de laboratorios
* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/
import 'package:applaluz/bloc/main_provider.dart';
import 'package:applaluz/helper/areas.dart';
import 'package:applaluz/models/Laboratorio.dart';
import 'package:applaluz/models/Teleconsulta.dart';
import 'package:applaluz/screens/laboratory_ticket_screen/laboratory_ticket_screen.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';
import 'package:applaluz/screens/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'package:applaluz/constants.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:applaluz/utils/utils.dart';

class HistoryLaboratory extends StatefulWidget {
  static String routeName = "/history_laboratory";
  HistoryLaboratory({Key key}) : super(key: key);

  @override
  _HistoryLaboratoryState createState() => _HistoryLaboratoryState();
}

class _HistoryLaboratoryState extends State<HistoryLaboratory> {
  //Abrir pdf
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final laboratorioBloc = MainProvider.laboratorioBLoc(context);
    laboratorioBloc.getLaboratoriosData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('HISTORIAL DE',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kTextColor,
                    letterSpacing: 12.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300)),
            Text(
              'LABORATORIOS',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: kPrimaryColor,
                  letterSpacing: 12.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        //backgroundColor: kPrimaryColor,
      ),
      body: StreamBuilder(
          stream: laboratorioBloc.laboratorioStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Laboratorio>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(160)),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          // SizedBox(height: SizeConfig.screenHeight * 0.02),
                          Image.asset(
                            "assets/images/iconolaluz.png",
                            fit: BoxFit.contain,
                            height: getProportionateScreenHeight(80),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '¡Aún no tienes resultados de laboratorio!',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0))
                      ])),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      Container(
                        height: 40.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MenuScreen.routeName);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(0)),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minWidth: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Ir a la vista principal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                );
              }
              return GroupedListView<Laboratorio, String>(
                elements: snapshot.data,
                groupBy: (item) => Areas.areasList[int.parse(item.area)].title,
                groupSeparatorBuilder: (groupValue) => Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(40)),
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: getProportionateScreenWidth(8),
                                  right: getProportionateScreenWidth(8)),
                              child: Text(
                                groupValue,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: getProportionateScreenWidth(8),
                              height: getProportionateScreenWidth(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kPrimaryColor),
                            ),
                            Expanded(
                              child: Divider(color: kPrimaryColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemBuilder: (context, item) {
                  String nombre = '';
                  if (item.descripcion != null) {
                    nombre = item.descripcion.split('-')[1].trim();
                  }

                  return Card(
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(6)),
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(8),
                                          right:
                                              getProportionateScreenWidth(8)),
                                      child: Text(
                                        "Tc." + " " + item.responsable,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(8)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.calendar_today,
                                              color: Colors.red, size: 16),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        8)),
                                            child: Text(item.fecha),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(8)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.person,
                                              color: kPrimaryColor, size: 16),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      getProportionateScreenWidth(
                                                          8)),
                                              child: Text(
                                                (item.descripcion != null)
                                                    ? nombre
                                                    : 'Sin Datos',
                                                maxLines: 8,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //   Padding(padding: EdgeInsets.only(right: getProportionateScreenWidth(10))),
                            Ink(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(10)),
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.description,
                                    color: Colors.white),
                                iconSize: 25.0,
                                splashColor: Colors.red,
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(10)),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, LaboratoryTicketScreen.routeName,
                                      arguments: item);
                                },
                              ),
                            ),
                            Ink(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(10)),
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.file_download,
                                    color: Colors.white),
                                iconSize: 25.0,
                                splashColor: Colors.red,
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(10)),
                                onPressed: () {
                                  if (item.archivo == null) {
                                    showAlertLaboratorio(context,
                                        "Aún no se ha subido el archivo de los resultados");
                                  } else {
                                    launchInBrowser(item.archivo);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ));
                },
                groupComparator: (group1, group2) => group1.compareTo(group2),
                itemComparator: (item1, item2) =>
                    item1.fecha.compareTo(item2.fecha),
                useStickyGroupSeparators: true,
                floatingHeader: false,
                order: GroupedListOrder.ASC,
              );
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

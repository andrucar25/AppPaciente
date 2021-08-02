import 'package:applaluz/bloc/main_provider.dart';
import 'package:applaluz/models/Teleconsulta.dart';
import 'package:applaluz/screens/medic_menu/medic_menu_screen.dart';
import 'package:applaluz/screens/teleconsultation_info/teleconsultation_info_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:applaluz/constants.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:applaluz/utils/utils.dart';

class TeleconsultaPendiente extends StatefulWidget {
  TeleconsultaPendiente({Key key}) : super(key: key);

  @override
  _TeleconsultaPendienteState createState() => _TeleconsultaPendienteState();
}

class _TeleconsultaPendienteState extends State<TeleconsultaPendiente> {
//Imagen momentanea
  final String image = "https://picsum.photos/200/300?random=8";
  //Abrir google meet
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
    final teleconsultaBloc = MainProvider.teleconsultaBloc(context);
    teleconsultaBloc.getTeleconsultasPendientes();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('TELECONSULTAS',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kTextColor,
                    letterSpacing: 12.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300)),
            Text(
              'PENDIENTES',
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
          stream: teleconsultaBloc.teleconsultaStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Teleconsulta>> snapshot) {
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
                            text: '¡Aún no tienes teleconsultas pendientes!',
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
                            Navigator.pushNamed(
                                context, MedicMenuScreen.routeName);
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
                                'Ver Especialidades',
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
              return GroupedListView<Teleconsulta, String>(
                elements: snapshot.data,
                groupBy: (item) => item.especialidad,
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
                              flex: 2,
                              child: Image(
                                  image: NetworkImage(item.foto),
                                  fit: BoxFit.cover),
                              //borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
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
                                        "Dr." +
                                            " " +
                                            item.nombresMedico +
                                            " " +
                                            item.apellidosMedico,
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
                                          Icon(Icons.alarm,
                                              color: kPrimaryColor, size: 16),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        8)),
                                            child: Text(item.hora),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(0),
                                          top:
                                              getProportionateScreenHeight(20)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        8)),
                                            child: RaisedButton.icon(
                                              icon: Icon(Icons.info),
                                              label: Text(
                                                "Información",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              elevation: 0.0,
                                              color: kPrimaryColor,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    TeleconsultationInfoScreen
                                                        .routeName,
                                                    arguments: item);
                                              },
                                            ),
                                          )
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
                                icon: Icon(Icons.logout, color: Colors.white),
                                iconSize: 25.0,
                                splashColor: Colors.red,
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(10)),
                                onPressed: () {
                                  if (item.enlace == null) {
                                    showAlertTeleconsultaPendiente(context,
                                        "El médico aún no ha subido el enlace de google meet");
                                  } else {
                                    launchInBrowser(item.enlace);
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

/*

* Screen para listar los medicos disponibles en cada especialidad

* 

* @author Andres De la Barra Vasquez

* @version 1.0 

*/ 
import 'package:applaluz/bloc/main_provider.dart';
import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/screens/medic_screen/medic_screen.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'package:applaluz/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ListMedicScreen extends StatefulWidget {
  static String routeName = "/list_medic_screen";

  @override
  _ListMedicScreenState createState() => _ListMedicScreenState();
}

class _ListMedicScreenState extends State<ListMedicScreen> {
  final double _borderRadius = 24;

  final double amount = 55.00;
  //Abrir archivo
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
    RouteSettings settings = ModalRoute.of(context).settings;
    final int especialidad = settings.arguments;

    final medicoBloc = MainProvider.medicoBloc(context);
    medicoBloc.getMedicosData();

    List<String> listaEspecialidades = <String>[];
    listaEspecialidades.add("Reumatologia");
    listaEspecialidades.add("Cardiologia");
    listaEspecialidades.add("Fisiatria ");
    listaEspecialidades.add("Neumologia");
    listaEspecialidades.add("Oftalmologia");
    listaEspecialidades.add("Gastroenterologia");

    return Scaffold(
          appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('MÉDICOS DE',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kTextColor,
                    letterSpacing: 12.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300)),
            Text(
              'ESPECIALIDAD',
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
          stream: medicoBloc.medicoStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Medico>> snapshot) {
            if (snapshot.hasData) {
              final medicos = <Medico>[];
              snapshot.data.forEach((element) {
                if (element.idEspecialidad == especialidad) {
                  medicos.add(element);
                }
              });

              return ListView.builder(
                itemCount: medicos.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_borderRadius),
                              color: kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                    width: getProportionateScreenHeight(20)),
                                Expanded(
                                  child: Image(
                                    image: NetworkImage(medicos[index].foto),
                                    height: getProportionateScreenHeight(160),
                                    width: 70,
                                  ),
                                  flex: 2,
                                ),
                                SizedBox(
                                    width: getProportionateScreenHeight(15)),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        ("Dr." +
                                            " " +
                                            medicos[index].nombres +
                                            " " +
                                            medicos[index].apellidos),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        listaEspecialidades[
                                            medicos[index].idEspecialidad - 1],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(16)),
                                      Row(
                                        children: <Widget>[
                                          RaisedButton.icon(
                                            icon: Icon(Icons.file_download),
                                            label: Text(
                                              "CV",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            elevation: 0.0,
                                            color: Colors.redAccent,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              launchInBrowser(
                                                  medicos[index].cv);
                                            },
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      70)),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "S/" + "$amount" + "0",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              // RatingBar(rating: items[index].rating),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          RaisedButton.icon(
                                            icon: Icon(Icons.date_range),
                                            label: Text(
                                              "Agendar cita",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            elevation: 0.0,
                                            color: Colors.redAccent,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  MedicScreen.routeName,
                                                  arguments: medicos[index]);
                                            },
                                          ),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenHeight(
                                                      8)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}

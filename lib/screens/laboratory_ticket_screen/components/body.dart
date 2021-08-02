import 'package:applaluz/components/default_appbar.dart';
import 'package:applaluz/helper/areas.dart';
import 'package:applaluz/models/Laboratorio.dart';

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LaboratoryTicketBody extends StatefulWidget {
  @override
  _LaboratoryBodyState createState() => _LaboratoryBodyState();
}

class _LaboratoryBodyState extends State<LaboratoryTicketBody> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    final Laboratorio laboratorio = settings.arguments;
    String dni = laboratorio.descripcion.split('-')[0].trim();
    String nombre = laboratorio.descripcion.split('-')[1].trim();
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
              bottom: getProportionateScreenWidth(50),
              top: getProportionateScreenWidth(50),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ticket de Laboratorio #${laboratorio.idLaboratorio}',
                          style: TextStyle(
                              fontSize: 25,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: Text(
                                'Valido solo por  2 dias habiles posterior a la fecha de registro.',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: kSecondaryColor,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        Center(
                          child: Image.asset(
                            'assets/images/iconolaluz.png',
                            height: 100.0,
                          ),
                        ),
                        SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        dataTitle('Fecha de Registro', laboratorio.fecha),
                        SizedBox(
                          width: 23.0,
                        ),
                        dataTitle('Área',
                            Areas.areasList[int.parse(laboratorio.area)].title),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        dataTitle('Responsable', laboratorio.responsable),
                        SizedBox(
                          width: 23.0,
                        ),
                        dataTitle('DNI Paciente', dni),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  dataTitle('Nombre del Paciente', nombre),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dataTitle(String title, String data) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: kSecondaryColor),
          ),
          SizedBox(
            width: 18.0,
          ),
          Flexible(
            child: Text(
              data,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

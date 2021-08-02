import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/screens/menu_screen/menu_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class CardPayment extends StatelessWidget {
  const CardPayment({this.fechaHora, this.medico});
  final Medico medico;
  final String fechaHora;

  @override
  Widget build(BuildContext context) {
    Event buildEvent() {
      DateTime fechaFormat = DateTime.parse(fechaHora);
      int diaFecha = fechaFormat.day;
      int mesFecha = fechaFormat.month;
      int anioFecha = fechaFormat.year;
      int horaFecha = fechaFormat.hour;
      int minutoFecha = fechaFormat.minute;
      String especialidad = getEspecialidadName(medico.idEspecialidad);
      return Event(
        title: 'Teleconsulta Agendada Clínica La Luz',
        description:
            'Teleconsulta agendada en $especialidad con el Dr.${medico.nombres} ${medico.apellidos}',
        location: 'Clinica La Luz - Tacna, Peru',
        startDate:
            DateTime(anioFecha, mesFecha, diaFecha, horaFecha, minutoFecha),
        endDate: DateTime(anioFecha, mesFecha, diaFecha, horaFecha,
            minutoFecha + 30), //DateTime.now().add(Duration(minutes: 30)),
        allDay: false,
        iosParams: IOSParams(
          reminder: Duration(minutes: 30),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(130),
          bottom: getProportionateScreenHeight(165),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Stack(
          children: <Widget>[
            _fondoCard(),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(30),
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
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
                        text: 'Registraste exitosamente una teleconsulta!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0))
                  ])),
                  SizedBox(height: 20.0),
                  Text('\S/55.00',
                      style: TextStyle(
                          color: Color.fromRGBO(64, 108, 108, 1.0),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          maxRadius: 20.0,
                          backgroundImage: NetworkImage(medico.foto),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${medico.nombres} ${medico.apellidos}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                            Text(getEspecialidadName(medico.idEspecialidad),
                                style: TextStyle(
                                    color: Color.fromRGBO(239, 128, 88, 1.0),
                                    fontSize: 14.0)),
                            Text(fechaHora,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Divider(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Ahora presiona el botón Continuar',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0))
                  ])),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Text('para visualizar tu teleconsulta agendada',
                      style: TextStyle(
                          color: Color.fromRGBO(123, 123, 123, .7),
                          fontSize: 12.0)),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Container(
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        Add2Calendar.addEvent2Cal(
                          buildEvent(),
                        );
                        Navigator.pushReplacementNamed(
                            context, MenuScreen.routeName);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(getProportionateScreenWidth(0)),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minWidth: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Continuar',
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _fondoCard() {
    return Container(
      width: 350.0,
      height: 455.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -80.0,
            top: -80.0,
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color:
                      kPrimaryColor), //Color.fromRGBO(123, 123, 123, 1.0).withOpacity(0.3)),
            ),
          ),
        ],
      ),
    );
  }
}

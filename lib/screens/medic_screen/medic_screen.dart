/*

* Screen para agendar cita con medico

* 

* @author Sigfredo Aponte Roldan

* @version 1.0 

*/

import 'package:applaluz/bloc/main_provider.dart';
import 'package:applaluz/components/default_button.dart';
import 'package:applaluz/models/HorarioMedico.dart';
import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/screens/medic_screen/components/medic_info_appbar.dart';
import 'package:applaluz/screens/payment_screen/payment_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'package:applaluz/constants.dart';

import 'components/custom_radio.dart';

class MedicScreen extends StatefulWidget {
  static String routeName = "/medic_screen";

  @override
  _MedicScreenState createState() => _MedicScreenState();
}

class _MedicScreenState extends State<MedicScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  int selectedDay = 0;
  int selectedHour = 0;
  List<HorarioMedico> list = [];
  String dropdownValue = 'Julio';
  bool isLoading = false;
  void changeIndexHour(int index) {
    setState(() {
      selectedHour = index;
    });
  }

  void changeIndexDay(int index) {
    setState(() {
      selectedDay = index;
      selectedHour = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MainProvider.horarioMedicoBLoc(context);
    final Medico medico = ModalRoute.of(context).settings.arguments;
    bloc.getHorarioMedicoData(getMonthNumber(dropdownValue), medico.idMedico);

    return Container(
      child: Scaffold(
        bottomNavigationBar: bottomAppBar(context, medico),
        appBar: medicInfoAppBar(medico, context, _keyLoader),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/backsplash.png"),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, top: 15.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kTextColor,
                  ),
                  iconSize: 30,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String newValue) {
                    getMonthData(bloc, medico);
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Julio',
                    'Agosto',
                    'Septiembre',
                    'Octubre',
                    'Noviembre',
                    'Diciembre'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        '$value, 2021',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              StreamBuilder(
                  stream: bloc.horarioMedicoStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<HorarioMedico>> snapshot) {
                    if (isLoading)
                      return Container(
                        height: getProportionateScreenHeight(200.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        )),
                      );

                    if (snapshot.data == null)
                      return Container(
                        height: getProportionateScreenHeight(200.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                        )),
                      );

                    if (snapshot.data.length == 0) return emptyDates();

                    return dateSection(snapshot.data);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getMonthData(bloc, medico) async {
    isLoading = true;
    await bloc.getHorarioMedicoData(
        getMonthNumber(dropdownValue), medico.i6dMedico);

    Future.delayed(
      Duration(milliseconds: 1),
      () => isLoading = false,
    );
  }

  Widget bottomAppBar(BuildContext contex, Medico medico) {
    return BottomAppBar(
      child: Container(
        // color: Colors.grey[200],
        width: double.infinity,
        // height: _screenSize.height * 0.09,
        height: getProportionateScreenHeight(80.0),
        decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          )
        ]),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            // width: _screenSize.width * 0.65,
            width: getProportionateScreenWidth(300.0),
            child: Builder(builder: (BuildContext context) {
              return DefaultIconButton(
                icon: Icons.monetization_on,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new PaymentScreen(
                          fechaHora:
                              "${list[selectedDay].dia.year}-${list[selectedDay].dia.month.toString().padLeft(2, '0')}-${list[selectedDay].dia.day.toString().padLeft(2, '0')} ${list[selectedDay].horasDisponibles[selectedHour].padLeft(2, '0')}:00",
                          medico: medico),
                    ),
                  );
                },
                text: 'Agendar por S/.55',
              );
            }),
          ),
        ),
      ),
    );
  }

  emptyDates() {
    return Center(
      child: Icon(
        Icons.sentiment_very_dissatisfied,
        color: kPrimaryColor,
        size: 150.0,
      ),
    );
  }

  dateSection(List<HorarioMedico> horarioList) {
    list = horarioList;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: kTextColor,
                    size: 20.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Selecciona un dia:',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ver Todo',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor,
                    size: 17.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        builRadioDay(context, horarioList, changeIndexDay, selectedDay),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 20.0,
                    color: kTextColor,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Selecciona un hora:',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ver Todo',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor,
                    size: 17.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        builRadioHour(context, horarioList[selectedDay].horasDisponibles,
            changeIndexHour, selectedHour),
      ],
    );
  }
}

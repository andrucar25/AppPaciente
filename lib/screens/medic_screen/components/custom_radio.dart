import 'package:applaluz/models/HorarioMedico.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

Widget customRadioHour(
    String data, int index, Function changeIndexHour, int selectedHour) {
  return GestureDetector(
    onTap: () => changeIndexHour(index),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      elevation: 5.0,
      color: selectedHour == index ? kPrimaryColor : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            (int.parse(data.split(':')[0]) < 12)
                ? Icon(
                    Icons.brightness_7,
                    color: selectedHour == index ? Colors.white : kTextColor,
                  )
                : Icon(
                    Icons.brightness_3_rounded,
                    color: selectedHour == index ? Colors.white : kTextColor,
                  ),
            SizedBox(
              width: 2.0,
            ),
            Text(
              data,
              style: TextStyle(
                  color: selectedHour == index ? Colors.white : kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(20.0)),
            ),
            (int.parse(data.split(':')[0]) < 12)
                ? Text('AM',
                    style: TextStyle(
                        color:
                            selectedHour == index ? Colors.white : kTextColor))
                : Text('PM',
                    style: TextStyle(
                        color:
                            selectedHour == index ? Colors.white : kTextColor)),
          ],
        ),
      ),
    ),
  );
}

Widget customRadioDay(
    HorarioMedico data, int index, Function changeIndexDay, int selectedDay) {
  return GestureDetector(
    onTap: () => changeIndexDay(index),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      color: selectedDay == index ? kPrimaryColor : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          children: [
            Text(
              weekday(data.dia.weekday),
              style: TextStyle(
                  color: selectedDay == index ? Colors.white : kTextColor,
                  fontSize: getProportionateScreenHeight(15.0)),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              data.dia.day.toString(),
              style: TextStyle(
                  color: selectedDay == index ? Colors.white : kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(25.0)),
            ),
          ],
        ),
      ),
    ),
  );
}

builRadioDay(BuildContext context, List<HorarioMedico> list,
    Function changeIndexDay, int selectedday) {
  return Container(
    height: getProportionateScreenHeight(80.0),
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return customRadioDay(list[index], index, changeIndexDay, selectedday);
      },
    ),
  );
}

builRadioHour(BuildContext context, List<String> list, Function changeIndexHour,
    int selectedHour) {
  return Container(
    height: getProportionateScreenHeight(55.0),
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return customRadioHour(
            list[index], index, changeIndexHour, selectedHour);
      },
    ),
  );
}

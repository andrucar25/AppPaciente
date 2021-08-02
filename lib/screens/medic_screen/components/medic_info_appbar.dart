import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/providers/chat_provider.dart';
import 'package:applaluz/screens/chat_screen/main_chat.dart';
import 'package:applaluz/screens/medic_screen/commentary_screen.dart';
import 'package:applaluz/utils/utils.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants.dart';

medicInfoAppBar(Medico medico, BuildContext context, _keyLoader) {
  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  return PreferredSize(
    preferredSize: Size.fromHeight(310.0),
    child: AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      elevation: 5.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Badge(
                elevation: 10.0,
                position: BadgePosition.bottomStart(),
                badgeColor: Colors.white,
                badgeContent: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text('150',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                          Container(
                            width: 50.0,
                            child: Text('Consultas Exitosas',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 11.0,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      medico.foto,
                      height: 200.0,
                      width: 140.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${medico.nombres} ${medico.apellidos}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0),
                        ),
                        Text(
                          getEspecialidadName(medico.idEspecialidad),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Calificacion de Atencion (61):',
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                    SizedBox(height: 5.0),
                    RatingBarIndicator(
                      unratedColor: kPrimaryColor,
                      itemBuilder: (context, index) => Icon(
                        Icons.sentiment_satisfied_alt,
                        color: Colors.white,
                      ),
                      itemCount: 5,
                      rating: 4.5,
                      itemSize: 30.0,
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      children: [
                        Badge(
                          badgeColor: Colors.amber,
                          badgeContent: Icon(Icons.monetization_on,
                              size: 18.0, color: Colors.white),
                          child: FloatingActionButton(
                              heroTag: 'chat',
                              mini: true,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.chat,
                                size: 20.0,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                findChat(context, _keyLoader, medico);
                              }),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        FloatingActionButton(
                            heroTag: 'cv',
                            mini: true,
                            backgroundColor: Colors.white,
                            child: Text(
                              'CV',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            onPressed: () {}),
                        SizedBox(
                          width: 10.0,
                        ),
                        FloatingActionButton(
                            heroTag: 'comment',
                            mini: true,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.comment,
                              size: 20.0,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CommentaryScreen.routeName,
                                  arguments: medico.idMedico);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> findChat(BuildContext context, _keyLoader, Medico medico) async {
  Dialogs.showLoadingDialog(context, _keyLoader, 'Espere un momento');
  ChatProvider chatprovider = new ChatProvider();
  String resp = await chatprovider.getChatMedico();
  if (resp == "Existe") {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    Navigator.pushNamed(context, MainChat.routeName);
  } else {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    showAlertChat(
        context,
        "Por un pago único de S/55.00, podrás desbloquear la función de chat, donde podrás solo enviar mensajes a los médicos de la clínica en cualquier momento",
        medico);
  }
}

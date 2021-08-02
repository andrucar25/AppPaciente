import 'package:applaluz/models/Comentario.dart';
import 'package:flutter/material.dart';
import 'package:applaluz/bloc/main_provider.dart';
import 'package:applaluz/utils/utils.dart';
import '../../size_config.dart';
import 'package:applaluz/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentaryScreen extends StatefulWidget {
  static String routeName = "/commentary_screen";

  @override
  _CommentaryScreenState createState() => _CommentaryScreenState();
}

class _CommentaryScreenState extends State<CommentaryScreen> {
  @override
  Widget build(BuildContext context) {
    int idMedico = ModalRoute.of(context).settings.arguments;
    final comentarioBloc = MainProvider.comentarioBLoc(context);
    comentarioBloc.getComentariosMedico(idMedico);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text('COMENTARIOS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: kTextColor,
                      letterSpacing: 12.0,
                      fontSize: getProportionateScreenHeight(18.0),
                      fontWeight: FontWeight.w300)),
              Text(
                'AL MÉDICO',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kPrimaryColor,
                    letterSpacing: getProportionateScreenWidth(12.0),
                    fontSize: getProportionateScreenHeight(18.0),
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            StreamBuilder(
              stream: comentarioBloc.comentarioStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Comentario>> snapshot) {
                if (snapshot.hasData) {
                  final comentarios = <Comentario>[];
                  snapshot.data.forEach((element) {
                    comentarios.add(element);
                  });
                  if (snapshot.data.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(200)),
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
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '¡Aún no tiene comentarios el médico!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        getProportionateScreenHeight(16.0)))
                          ])),
                        ],
                      )),
                    );
                  }
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: getProportionateScreenHeight(30),
                          );
                        },
                        itemCount: comentarios.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 CircleAvatar(
                                    maxRadius: 20.0,
                                    backgroundImage: NetworkImage(comentarios[i].paciente.foto),
                                  ),
                               /* Icon(
                                  Icons.account_circle,
                                  size: getProportionateScreenHeight(27),
                                ),*/
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[i].fecha,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    15.0)),
                                      ),
                                      Text(
                                        '${comentarios[i].paciente.nombres} ${comentarios[i].paciente.apellidos}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    15.0)),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(5.0),
                                      ),
                                      RatingBar.builder(
                                        initialRating: comentarios[i]
                                            .puntuacion
                                            .toDouble(),
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemSize:
                                            getProportionateScreenHeight(20.0),
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.sentiment_satisfied_alt,
                                          color: kPrimaryColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // score = rating.toInt();
                                        },
                                      ),
                                         SizedBox(
                                        height:
                                            getProportionateScreenHeight(2.0),
                                      ),
                                      Text(
                                        comentarios[i].descripcion,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            // fontSize: _screenSize.height * 0.018
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    15)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

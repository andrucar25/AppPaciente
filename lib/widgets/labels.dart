import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subTitulo;

  const Labels({
    Key key,
    @required this.ruta,
    @required this.titulo,
    @required this.subTitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.titulo,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w200)),
          SizedBox(height: 10),
          GestureDetector(
              child: Text(this.subTitulo,
                  style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushReplacementNamed(context, this.ruta);
              }),
        ],
      ),
    );
  }
}

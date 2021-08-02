/*

* Screen para el asistente de recomendacion

* 

* @author Juan Rodriguez Mamani

* @version 1.0 

*/ 
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../size_config.dart';

class AsistantScreen extends StatefulWidget {
  static String routeName = "/asistant";
  AsistantScreen({Key key, this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AsistantScreen> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/images/asistente/service.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('ASISTENTE DE',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kTextColor,
                    letterSpacing: 12.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300)),
            Text(
              'RECOMENDACIÓN',
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
     /* appBar: AppBar(
        title: Text(
          "Asistente de Recomendación La Luz",
        ),
      ),*/
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(15), bottom:  getProportionateScreenHeight(10)),
             
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Divider(
              height:  getProportionateScreenHeight(5.0),
              color: Colors.red[400],
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: getProportionateScreenHeight(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Ingrese un mensaje...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("Mensaje Vacio");
                      } else {
                        setState(() {
                          messsages.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        response(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            SizedBox(
              height:  getProportionateScreenHeight(15.0),
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    var bubble = Bubble(
        radius: Radius.circular(15.0),
        color:
            data == 0 ? kPrimaryColor : Colors.orange,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(2.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                  child: Container(
                constraints: BoxConstraints(maxWidth:  getProportionateScreenWidth(200)),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
            ],
          ),
        ));
    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenHeight(20), right:  getProportionateScreenHeight(20)),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                   decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.black,
                      width: 1.0,
                    )
                   ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    //radius: 50,
                    backgroundImage:
                        AssetImage("assets/images/iconolaluz.png"),
                  ),
                
                ):Container(),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(10.0)),
            child: bubble,
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/asistente/default.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

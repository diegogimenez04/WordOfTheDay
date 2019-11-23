import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  final String url = "https://jsonplaceholder.typicode.com/photos"; 
  /*
  Estas son algunas APIs para obtener datos
  https://jsonplaceholder.typicode.com/photos
  http://www.etnassoft.com/api/v1/get/?id=
  https://www.swapi.co/api/peopl
  https://es.wikiquote.org/wiki/Portada
  */
  String palabra = "";
  String definicion = "";
  String titulo = "";
  var foto;
  int pepe = 0;

  @override
  void initState(){
    super.initState();
    this.getJson();
  }

  int generateRandomNum(){
    var random = new Random();
    int num = random.nextInt(100);
    return num;
  }
  
  String palabraDelDia() {
    return (palabra);
  }

  // El async nos dice que puede no ejecutarse junto a todo lo otro
  Future<String> getJson() async{
    // El await nos dice que va a esperar a que termine esa funcion para seguir
    var response = await http.get(
      Uri.encodeFull(url),
      //Indica que solamente permite respuestas en json
      headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState(() {
      var pasarloAJson = jsonDecode(response.body);
      var id = generateRandomNum();
      titulo = pasarloAJson[id]['title'];
      foto = pasarloAJson[id]['url'];
    });

  }
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          "Aca podes ver el AppBar",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: new Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10, 20.0),
              child: new Card(
                child: new Text(
                  palabraDelDia(),
                  style: TextStyle(fontSize: 50)
                )
              )
            ),
            new Center(
              child: new Padding(
                padding: EdgeInsets.all(10.0),
                child: new Text(
                  "Holas",
                  style: TextStyle(color: Colors.white),
                  )
              )
            ),
            new Center(
              child: new FloatingActionButton(
                onPressed: () {
                  getJson();
                },
                child: Icon(Icons.replay),
                backgroundColor: Colors.green,
              )
            ),
            new Center(
              child: Text(generateRandomNum().toString()),
            )
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './web.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  final String url = "https://jsonplaceholder.typicode.com/posts"; 
  /*
  Estas son algunas APIs para obtener datos
  https://jsonplaceholder.typicode.com/photos
  https://jsonplaceholder.typicode.com/posts
  http://www.etnassoft.com/api/v1/get/?id=
  https://www.swapi.co/api/peopl
  https://es.wikiquote.org/wiki/Portada

  Para busquedas

  es.wikiquote.org/w/index.php?search=
  */
  String titulo = "";
  String descripcion = "";

  @override
  void dispose(){
    super.dispose();
  }

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

  // El async nos dice que puede no ejecutarse junto a todo lo otro
  Future<String> getJson() async{
    // El await nos dice que va a esperar a que termine esa funcion para seguir
    http.Response response = await http.get(
      Uri.encodeFull(url),
      //Indica que solamente permite respuestas en json
      headers: {"Accept": "application/json"}
    );

    setState(() {
      //Esta variable pasa lo que contiene el body de la response (basicamente todos los datos utiles) para que se pueda utilizar de la forma que vemos mas abajo
      var pasarloAJson = jsonDecode(response.body);
      var id = generateRandomNum();
      this.titulo = pasarloAJson[id]['title'];
      this.descripcion = pasarloAJson[id]['body'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[300],
        title: Text(
          "Una nueva frase para un nuevo dia",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:new Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10, 20.0),
              child: new Center(
                child: new Text(
                  '"$titulo"',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              )
            ),
            new Center(
              child: new Padding(
                padding: EdgeInsets.all(10.0),
                child: new Text(
                  '$descripcion',
                  style: TextStyle(color: Colors.white),
                  )
              )
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(18, 5, 18, 5),
              child: new AppBar(
                title: new Text("Podes buscar otra que te guste"),
                centerTitle: true,
                backgroundColor: Colors.blue[300],
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              )
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(130, 0, 130, 0),
              child: new OutlineButton(
                child: Icon(Icons.wifi_tethering, color: Colors.white),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Web())
                  );
                },
              )
            )
          ],
        ),
      )
    );
  }
}
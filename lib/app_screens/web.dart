import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Web extends StatefulWidget{
  Web({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web>{
  
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Icon(Icons.work),
      ),
      url: "https://es.wikiquote.org/wiki/Portada",
    );
  }

}
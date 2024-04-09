
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:alercom/src/utils/utils.dart';

class ChildScreen extends StatelessWidget{
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Text('Niñez y adolescencia',style: TextStyle(color: fontColor)),
        elevation: 2.0,
        backgroundColor: backgroundColor,
      ),
      body: WebView(
        initialUrl: 'https://www.icbf.gov.co/mis-manos-te-ensenan/conoce-la-ruta-de-atencion-en-casos-de-vulneracion-de-derechos-de-ninos-ninas-y',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

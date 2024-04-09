
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:alercom/src/utils/utils.dart';

class VictimsScreen extends StatelessWidget{
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Text('Victimas ley 1448',style: TextStyle(color: fontColor)),
        elevation: 2.0,
        backgroundColor: backgroundColor,
      ),
      body: WebView(
        initialUrl: 'https://www.fiscalia.gov.co/colombia/ruta-de-atencion-integral-a-victimas/',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

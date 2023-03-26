@JS()
library callable_function;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:js/js.dart';

class WebJs extends StatefulWidget {
  const WebJs({Key? key}) : super(key: key);

  @override
  State<WebJs> createState() => _WebJsState();
}

/// Allows assigning a function to be callable from `window.receiveData()`
@JS('receiveData')
external set _receiveData(void Function(String str) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void receiveData();

/// Allows assigning a function to be callable from `window.receiveListMapData()`
@JS('receiveListMapData')
external set _receiveListMapData(void Function(List<String> listMap) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void receiveListMapData();

/// Allows assigning a function to be callable from `window.receiveIntData()`
@JS('receiveIntData')
external set _receiveIntData(void Function(int id) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void receiveIntData();

/// Calls invoke JavaScript `window.flutter_inappwebview.callHandler(key, value)`.
@JS('window.flutter_inappwebview.callHandler')
external String toJs(String key, String value);

class _WebJsState extends State<WebJs> {
  @override
  void initState() {
    // TODO: implement initState
    _receiveData = allowInterop(_receiveDataFunc);
    _receiveListMapData = allowInterop(_receiveListMapDataFunc);
    _receiveIntData = allowInterop(_receiveIntDataFunc);
    _sendDataToJs("is_finish_load", "1");
    super.initState();
  }

  String _txt = "";
  String _txt2 = "";
  String _txt3 = "";

  void _receiveDataFunc(String str) {
    setState(() {
      _txt = "接收webview傳入的值: $str";
    });
  }

  void _receiveListMapDataFunc(List<String> listMap) {
    String val = "";
    for (int i = 0; i < listMap.length; i++) {
      Map map = json.decode(listMap[i]);
      val += map["value"];
    }
    setState(() {
      _txt2 = val;
    });
  }

  void _receiveIntDataFunc(int id) {
    setState(() {
      int receiveId = id;
      _txt3 = receiveId.toString();
    });
  }

  //傳值給web端
  void _sendDataToJs(String key, String value) {
    toJs(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _txt,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _txt2,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _txt3,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                _sendDataToJs("to_js", "幹");
              },
              child: const Text('點擊傳值給web'),
            ),
          ],
        ),
      ),
    );
  }
}

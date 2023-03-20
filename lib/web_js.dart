@JS()
library callable_function;

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
external set _receiveListMapData(
    void Function(List<Map<String, dynamic>> map) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void receiveListMapData();

/// Calls invoke JavaScript `window.flutter_inappwebview.callHandler(key, value)`.
@JS('window.flutter_inappwebview.callHandler')
external String toJs(String key, String value);

class _WebJsState extends State<WebJs> {
  @override
  void initState() {
    // TODO: implement initState
    _receiveData = allowInterop(_receiveDataFunc);
    _receiveListMapData = allowInterop(_receiveListMapDataFunc);
    _sendDataToJs("is_finish_load", "1");
    super.initState();
  }

  String _txt = "";
  String _txt2 = "";

  void _receiveDataFunc(String str) {
    setState(() {
      _txt = "接收webview傳入的值: $str";
    });
  }

  void _receiveListMapDataFunc(List<Map<String, dynamic>> map) {
    setState(() {
      _txt2 = map.toString();
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

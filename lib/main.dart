@JS()
library callable_function;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('進入與web溝通橋梁');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Allows assigning a function to be callable from `window.receiveData()`
@JS('receiveData')
external set _receiveData(void Function(String str) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void receiveData();

/// Calls invoke JavaScript `window.flutter_inappwebview.callHandler(key, value)`.
@JS('window.flutter_inappwebview.callHandler')
external String toJs(String key, String value);

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _receiveData = allowInterop(_receiveDataFunc);
    _sendDataToJs("is_finish_load", "1");
    super.initState();
  }

  String _txt = "";

  void _receiveDataFunc(String str) {
    setState(() {
      _txt = "接收webview傳入的值: $str";
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

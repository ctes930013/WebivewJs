import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:webview_js/router/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final router = FluroRouter();
    Application.router = router; // 先寫
    Routes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    print('進入與web溝通橋梁');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.root,
      onGenerateRoute: Application.router.generator,
    );
  }
}

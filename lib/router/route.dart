import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:webview_js/router/router_handler.dart';

//Fluro路由配置
class Application {
  static late final FluroRouter router;
}

// 路由配置
class Routes {
  static const String root = "/home";

  static void configureRoutes(FluroRouter router) {
    //找不到路由
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    //路由定義
    router.define(root, handler: rootHandler);
  }
}

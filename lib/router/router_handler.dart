import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:webview_js/web_js.dart';

//Handler配置
var rootHandler = Handler(handlerFunc: (BuildContext? context, params) {
  return const WebJs();
});

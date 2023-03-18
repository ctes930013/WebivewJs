# webview_js

本專案利用JS套件實作打包成H5後與App端的Webview做交互

## How to build

1. 執行`flutter clean & flutter build web`
2. 生成的檔案在build/web裡面，利用文字編輯器打開index.html，並找到以下`<base href="/">`，改成`<base href="">`
3. 將所有檔案放到server上，在本地會打不開

## Warning
- 由於內部呼叫了InAppWebview的js監聽語法，務必要用InAppWebview打開，否則報錯

## InAppWebview Link
[InAppWebview專案地址](https://github.com/ctes930013/Webview3)

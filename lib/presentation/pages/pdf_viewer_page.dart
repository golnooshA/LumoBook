// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PDFWebViewPage extends StatefulWidget {
//   final String url;
//   const PDFWebViewPage({super.key, required this.url});
//
//   @override
//   State<PDFWebViewPage> createState() => _PDFWebViewPageState();
// }
//
// class _PDFWebViewPageState extends State<PDFWebViewPage> {
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse('https://docs.google.com/gview?embedded=true&url=${widget.url}'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Read Book")),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/config/design_config.dart';

class PDFWebViewPage extends StatefulWidget {
  final String url;
  const PDFWebViewPage({super.key, required this.url});

  @override
  State<PDFWebViewPage> createState() => _PDFWebViewPageState();
}

class _PDFWebViewPageState extends State<PDFWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: DesignConfig.appBarBackgroundColor,
      centerTitle: true,
      title: Text(
        'Read Book',
        style: TextStyle(
          color: DesignConfig.appBarTitleColor,
          fontSize: DesignConfig.appBarTitleFontSize,
          fontFamily: DesignConfig.fontFamily,
          fontWeight: DesignConfig.fontWeight,
        ),
      ),
    ),
    body: WebViewWidget(controller: _controller),
    );
  }
}

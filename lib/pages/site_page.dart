import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  WebViewController controller;

  int _stackIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Site'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _onClickRefresh(),
          ),
        ],
      ),
      body: _webView(),
    );
  }

  IndexedStack _webView() {
    return IndexedStack(
      index: _stackIndex,
      children: <Widget>[
        WebView(
          initialUrl: 'https://flutter.dev',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (request) {
            print(request.url);
            return NavigationDecision.navigate;
          },
          onPageFinished: _onPageFinished,
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  _onClickRefresh() {
    this.controller.reload();
  }

  void _onPageFinished(String value) {
    setState(() {
      _stackIndex = 0;
    });
  }
}

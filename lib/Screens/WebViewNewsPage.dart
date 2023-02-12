import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNewsPage extends StatefulWidget {
  final String postUrl;
  const WebViewNewsPage({Key? key, required this.postUrl}) : super(key: key);

  @override
  _WebViewNewsPageState createState() => _WebViewNewsPageState();
}

class _WebViewNewsPageState extends State<WebViewNewsPage> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: WebView(
                  onProgress: (progress) {
                    print(progress);
                  },
                  zoomEnabled: true,
                  onWebResourceError: (error) {
                    GFToast.showToast(
                        "Error while fetching resource...", context,
                        toastPosition: GFToastPosition.BOTTOM);
                  },
                  key: _key,
                  navigationDelegate: (NavigationRequest request) {
                    return NavigationDecision.prevent;
                  },
                  javascriptMode: JavascriptMode.disabled,
                  initialUrl: widget.postUrl))
        ],
      ),
    );
  }
}

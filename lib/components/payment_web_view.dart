import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class WebViewScreenPay extends StatefulWidget {
  final String uri;

  const WebViewScreenPay({super.key, required this.uri});

  @override
  State<WebViewScreenPay> createState() => _WebViewScreenPayState();
}

class _WebViewScreenPayState extends State<WebViewScreenPay> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: _onPageFinished,
      ))
      ..loadRequest(Uri.parse(widget.uri));
  }

  Future<void> _onPageFinished(String url) async {
    print('✅ Finished loading: $url');

    // لو عايز تراقب عنوان الصفحة فقط
    if (url.contains('success')) {
      try {
        final resultString = await _controller.runJavaScriptReturningResult(
          "document.body.innerText",
        );

        // أزل علامات escape
        final cleaned = resultString
            .toString()
            .replaceAll(r'\n', '')
            .replaceAll(r'\"', '"');

        // احذف علامات الاقتباس الخارجية (لأن Flutter ترجع string بين double quotes)
        final trimmed = cleaned.substring(1, cleaned.length - 1);

        // حوله لـ JSON
        final Map<String, dynamic> data = json.decode(trimmed);

        Navigator.pop(context, data);
      } catch (e) {
        Navigator.pop(
            context, {"status": false, "message": "فشل قراءة رد السيرفر: $e"});
      }
    }

    if (url.contains('failed') || url.contains('failure')) {
      Navigator.pop(context, {"status": false, "message": "فشل الدفع"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(
              context, {"status": false, "message": "تم إلغاء العملية"}),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

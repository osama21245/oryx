import 'package:flutter/material.dart';
import '../extensions/extension_util/context_extensions.dart';

import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/images.dart';

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }


  void init() async {
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(no_internet, height: context.height() * 0.2, width: context.width() * 0.4),
          16.height,
          Text(language.noInternet, style: boldTextStyle(size: 20)),
        ],
      ).center(),
    );
  }
}

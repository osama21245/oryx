import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../extensions/extension_util/bool_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../utils/app_common.dart';

class YouTubeEmbedWidget extends StatelessWidget {
  final String videoId;
  final bool? fullIFrame;

  YouTubeEmbedWidget(this.videoId, {this.fullIFrame});

  @override
  Widget build(BuildContext context) {
    String path = fullIFrame.validate() ? videoId : 'https://www.youtube.com/embed/$videoId';

    return IgnorePointer(
      ignoring: true,
      // child: Html(
      //   data: fullIFrame.validate()
      //       ? '<html><iframe height="200" style="width:100%" src="$path"></iframe></html>'
      //       : '<html><iframe height="200" style="width:100%" src="$path" allow="autoplay; fullscreen" allowfullscreen="allowfullscreen"></iframe></html>',
      // ),
    ).onTap(() {
      launchUrls(path, forceWebView: true);
    });
  }
}

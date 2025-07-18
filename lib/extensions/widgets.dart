import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../extensions/system_utils.dart';
import '../extensions/text_styles.dart';
import '../utils/constants.dart';
import 'common.dart';
import 'confirmation_dialog.dart';
import 'loader_widget.dart';

/// show confirm dialog box
Future<bool?> showConfirmDialog<bool>(
  context,
  String title, {
  String positiveText = 'Yes',
  String negativeText = 'No',
  Color? buttonColor,
  Color? barrierColor,
  bool? barrierDismissible,
  Function? onAccept,
}) async {
  return showDialog(
    context: context,
    // barrierDismissible: barrierDismissible ?? false,
    builder: (_) => AlertDialog(
      title: Text(title.validate(), style: primaryTextStyle()),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(negativeText.validate(), style: secondaryTextStyle()),
          onPressed: () {
            finish(_, false);
          },
        ),
        SimpleDialogOption(
          onPressed: () {
            finish(_, true);

            onAccept?.call();
          },
          child: Text(
            positiveText.validate(),
            style: primaryTextStyle(color: buttonColor ?? Theme.of(_).primaryColor),
          ),
        ),
      ],
    ),
  );
}

/// show child widget in dialog
Future<T?> showInDialog<T>(
  BuildContext context, {
  Widget? title,
  @Deprecated('Use builder instead') Widget? child,
  Widget? Function(BuildContext)? builder,
  ShapeBorder? shape,
  TextStyle? titleTextStyle,
  EdgeInsetsGeometry? contentPadding,
  //bool scrollable = false,
  Color? backgroundColor,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  double? elevation,
  Color? barrierColor,
  //EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  List<Widget>? actions,
  bool barrierDismissible = true,
  bool hideSoftKeyboard = true,
  Duration? transitionDuration,
  Curve curve = Curves.easeInBack,
}) async {
  if (hideSoftKeyboard) hideKeyboard(context);

  return await showGeneralDialog<T>(
    context: context,
    barrierColor: barrierColor ?? Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    barrierLabel: '',
    barrierDismissible: barrierDismissible,
    transitionDuration: transitionDuration ?? 400.milliseconds,
    transitionBuilder: (_, animation, secondaryAnimation, c) {
      return dialogAnimatedWrapperWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        curve: curve,
        child: AlertDialog(
          content: builder != null ? builder.call(_) : child,
          shape: shape ?? defaultDialogShape,
          title: title,
          titleTextStyle: titleTextStyle,
          contentPadding: contentPadding ?? EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          //scrollable: scrollable,
          backgroundColor: backgroundColor,
          elevation: elevation ?? defaultElevation.toDouble(),
          //insetPadding: insetPadding,
          actions: actions,
        ),
      );
    },
  );
}

/// Handle error and loading widget when using FutureBuilder or StreamBuilder
Widget snapWidgetHelper<T>(
  AsyncSnapshot<T> snap, {
  Widget? errorWidget,
  Widget? loadingWidget,
  String? defaultErrorMessage,
  @Deprecated('Do not use this') bool checkHasData = false,
  Widget Function(String)? errorBuilder,
}) {
  if (snap.hasError) {
    log(snap.error);
    if (errorBuilder != null) {
      return errorBuilder.call(defaultErrorMessage ?? snap.error.toString());
    }
    return errorWidget ??
        Text(
          defaultErrorMessage ?? snap.error.toString(),
          style: primaryTextStyle(),
        ).center();
  } else if (!snap.hasData) {
    return loadingWidget ?? Loader();
  } else {
    return SizedBox();
  }
}

/// Returns true is snapshot is loading
bool isSnapshotLoading(AsyncSnapshot snap, {bool checkHasData = false}) {
  return snap.connectionState == ConnectionState.active || snap.connectionState == ConnectionState.waiting;
}

// /// html widget
// htmlWidget(BuildContext context, String postContent, Color color, TextStyle style) {
//   return HtmlWidget(
//     postContent,
//     onErrorBuilder: (context, element, error) => Text('$element error: $error'),
//     onLoadingBuilder: (context, element, loadingProgress) => CircularProgressIndicator(),
//     onTapUrl: (p0) {
//       WebViewScreen(mInitialUrl: p0.validate()).launch(context);
//       return true;
//     },
//     renderMode: RenderMode.column,
//     textStyle: style,
//   );
// }

void openPhotoViewer(BuildContext context, ImageProvider imageProvider) {
  Scaffold(
    body: Stack(
      children: <Widget>[
        PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: 1.0,
        ),
        Positioned(top: 35, left: 16, child: BackButton(color: Colors.white)),
      ],
    ),
  ).launch(context);
}

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../extensions/extension_util/context_extensions.dart';

import '../../extensions/text_styles.dart';
import '../main.dart';
import '../utils/constants.dart';
import 'colors.dart';

/// returns default InputDecoration for AppTextField widget
InputDecoration defaultInputDecoration(
  BuildContext context, {
  String? hint,
  String? label,
  Color? fillColor,
  TextStyle? textStyle,
  bool? isFocusTExtField = false,
  Widget? mPrefix,
}) {
  return InputDecoration(
    filled: true,
    fillColor: appStore.isDarkModeOn ? cardDarkColor : fillColor ?? primaryExtraLight,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    prefixIcon: mPrefix ?? null,
    border: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? Colors.transparent : Colors.transparent)),
    // border: OutlineInputBorder(borderRadius: radius(), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : context.dividerColor.withOpacity(0.7))),
    focusedErrorBorder: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : primaryColor)),
    disabledBorder: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : context.dividerColor.withOpacity(0.7))),
    focusedBorder: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : primaryColor)),
    enabledBorder: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : Colors.transparent)),
    errorBorder: OutlineInputBorder(borderRadius: radius(8), borderSide: BorderSide(color: isFocusTExtField == true ? context.dividerColor.withOpacity(0.7) : Colors.red)),
    alignLabelWithHint: true,
    // filled: true,
    isDense: true,
    labelText: label ?? "Sample Text",
    labelStyle: secondaryTextStyle(),
  );
}

/// returns Radius
BorderRadius radius([double? radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

/// returns Radius
Radius radiusCircular([double? radius]) {
  return Radius.circular(radius ?? defaultRadius);
}

ShapeBorder dialogShape([double? borderRadius]) {
  return RoundedRectangleBorder(
    borderRadius: radius(borderRadius ?? defaultRadius),
  );
}

/// returns custom Radius on each side
BorderRadius radiusOnly({
  double? topRight,
  double? topLeft,
  double? bottomRight,
  double? bottomLeft,
}) {
  return BorderRadius.only(
    topRight: radiusCircular(topRight ?? 0),
    topLeft: radiusCircular(topLeft ?? 0),
    bottomRight: radiusCircular(bottomRight ?? 0),
    bottomLeft: radiusCircular(bottomLeft ?? 0),
  );
}

Decoration boxDecorationDefault({
  BorderRadiusGeometry? borderRadius,
  Color? color,
  Gradient? gradient,
  BoxBorder? border,
  BoxShape? shape,
  BlendMode? backgroundBlendMode,
  List<BoxShadow>? boxShadow,
  DecorationImage? image,
}) {
  return BoxDecoration(
    borderRadius: (shape != null && shape == BoxShape.circle) ? null : (borderRadius ?? radius()),
    boxShadow: boxShadow ?? defaultBoxShadow(),
    color: color ?? Colors.white,
    gradient: gradient,
    border: border,
    shape: shape ?? BoxShape.rectangle,
    backgroundBlendMode: backgroundBlendMode,
    image: image,
  );
}

/// rounded box decoration
Decoration boxDecorationWithRoundedCorners({
  Color? backgroundColor,
  BorderRadius? borderRadius,
  LinearGradient? gradient,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
  DecorationImage? decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    color: backgroundColor == null
        ? appStore.isDarkModeOn
            ? cardDarkColor
            : cardLightColor
        : backgroundColor,
    borderRadius: boxShape == BoxShape.circle ? null : (borderRadius ?? radius()),
    gradient: gradient,
    border: border,
    boxShadow: boxShadow,
    image: decorationImage,
    shape: boxShape,
  );
}

/// box decoration with shadow
Decoration boxDecorationWithShadow({
  Color? backgroundColor,
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
  LinearGradient? gradient,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
  DecorationImage? decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
  BorderRadius? borderRadius,
}) {
  print(backgroundColor);
  return BoxDecoration(
    boxShadow: boxShadow ??
        defaultBoxShadow(
          shadowColor: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
    color: backgroundColor == null
        ? appStore.isDarkModeOn
            ? cardDarkColor
            : cardLightColor
        : backgroundColor,
    gradient: gradient,
    border: border,
    image: decorationImage,
    shape: boxShape,
    borderRadius: borderRadius,
  );
}

/// rounded box decoration with shadow
Decoration boxDecorationRoundedWithShadow(
  int radiusAll, {
  Color? backgroundColor,
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0, 0),
  LinearGradient? gradient,
}) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? Colors.grey.withOpacity(0.065),
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    ),
    color: backgroundColor == null
        ? appStore.isDarkModeOn
            ? cardDarkColor
            : cardLightColor
        : backgroundColor,
    gradient: gradient,
    borderRadius: radius(radiusAll.toDouble()),
  );
}

/// default box shadow
List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? Colors.grey.withOpacity(0.065),
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}

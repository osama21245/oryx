import 'package:flutter/material.dart';
import '../extensions/colors.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../extensions/text_styles.dart';
import '../utils/constants.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final double? width;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final Function? onTap;
  final EdgeInsets? padding;
  final int paddingAfterLeading;
  final int paddingBeforeTrailing;
  final Color? titleTextColor;
  final Color? subTitleTextColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Decoration? decoration;
  final double? borderRadius;
  final BorderRadius? radius;

  SettingItemWidget({
    required this.title,
    this.onTap,
    this.width,
    this.subTitle = '',
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.padding,
    this.paddingAfterLeading = 16,
    this.paddingBeforeTrailing = 16,
    this.titleTextColor,
    this.subTitleTextColor,
    this.decoration,
    this.borderRadius,
    this.hoverColor,
    this.splashColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: decoration ?? BoxDecoration(color: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight, borderRadius: BorderRadius.circular(12)),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          leading ?? SizedBox(),
          if (leading != null) paddingAfterLeading.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.validate(), style: titleTextStyle ?? primaryTextStyle(color: titleTextColor ?? textPrimaryColorGlobal), maxLines: 1, overflow: TextOverflow.ellipsis),
              4.height.visible(subTitle.validate().isNotEmpty),
              if (subTitle.validate().isNotEmpty)
                Text(subTitle!, style: subTitleTextStyle ?? secondaryTextStyle(color: subTitleTextColor ?? textSecondaryColorGlobal), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
          if (trailing != null) paddingBeforeTrailing.width,
          trailing ?? SizedBox(),
        ],
      ),
    ).onTap(onTap, borderRadius: radius, hoverColor: hoverColor, splashColor: splashColor);
  }
}

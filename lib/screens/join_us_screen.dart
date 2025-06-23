import 'package:flutter/material.dart';
import 'package:orex/extensions/app_button.dart';
import 'package:orex/extensions/extension_util/context_extensions.dart';
import 'package:orex/extensions/extension_util/int_extensions.dart';
import 'package:orex/extensions/extension_util/widget_extensions.dart';
import 'package:orex/generated/assets.dart';
import 'package:orex/main.dart';
import 'package:orex/screens/dashboard_screen.dart';
import 'package:orex/screens/login_screen.dart';
import 'package:orex/utils/colors.dart';

class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.joinus,
            ),
            15.height,
            Text(
              'سجل الان',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            20.height,
            AppButton(
              text: 'تسجيل',
              width: context.width(),
              color: primaryColor,
              textColor: Colors.white,
              onTap: () {
                LoginScreen().launch(context, isNewTask: false);
              },
            ).paddingOnly(right: 16, bottom: 16, left: 16, top: 0),
            AppButton(
              text: 'تسجيل كضيف',
              width: context.width(),
              color: Color(0xffE9E9E9),
              textColor: primaryColor,
              onTap: () {
                DashboardScreen(
                  isSplash: true,
                ).launch(context, isNewTask: true);
              },
            ).paddingOnly(right: 16, bottom: 16, left: 16, top: 0),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:orex/generated/assets.dart';

class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image.asset(Assets.joinus)],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage_controller.dart';

class HomepageView extends StatelessWidget {
  HomepageView({super.key});

  final HomepageController controller = HomepageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/main avatar.png'), fit: BoxFit.contain)),
      ),
    );
  }
}

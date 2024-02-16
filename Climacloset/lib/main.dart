import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage_view.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/homepage_model.dart'; // Import HomepageModel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize HomepageModel and make it globally accessible
    Get.put(HomepageModel());

    return GetMaterialApp(
      title: 'Clothing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomepageView(),
    );
  }
}

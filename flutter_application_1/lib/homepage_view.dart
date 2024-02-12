import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage_controller.dart';
import 'package:get/get.dart';

class HomepageView extends StatelessWidget {
  HomepageView({Key? key}) : super(key: key);

  final HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing Suggestions'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.resetData();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.model.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var item in controller.model.clothingItems)
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        controller.model.assetPathMap[item]!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      }),
    );
  }
}

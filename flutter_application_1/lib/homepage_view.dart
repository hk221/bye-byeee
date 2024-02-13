import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage_controller.dart';
import 'package:get/get.dart';

class HomepageView extends StatelessWidget {
  HomepageView({Key? key}) : super(key: key);

  final HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    // Call loadData when the view is built
    controller.loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Clothing suggestions'),
        actions: [
          // Add refresh button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call loadData again when refresh button is pressed
              controller.loadData();
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
                // Display Hat or Jacket
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      controller.model.hatPath.value.isNotEmpty
                          ? controller.model.hatPath.value
                          : controller.model.nohatPath.value,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Display Cold Top
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      controller.model.coldtopPath.value.isNotEmpty
                          ? controller.model.coldtopPath.value
                          : controller.model.jacketPath.value,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Display Hot Bottom or Cold Bottom
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      controller.model.hotbottomPath.value.isNotEmpty
                          ? controller.model.hotbottomPath.value
                          : controller.model.coldbottomPath.value,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Display Hot Shoes or Cold Shoes
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      controller.model.hotshoesPath.value.isNotEmpty
                          ? controller.model.hotshoesPath.value
                          : controller.model.coldshoesPath.value,
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

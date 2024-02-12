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
        title: Text('Clothing Suggestions'),
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
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      controller.model.hatPath.value, // RxString reference
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add spacing between images
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImage(controller.model.hot_shoesPath.value),
                  ),
                ),
                SizedBox(height: 20), // Add spacing between images
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImage(controller.model.coldtopPath.value),
                  ),
                ),
                SizedBox(height: 20), // Add spacing between images
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImage(controller.model.hot_bottomPath.value),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildImage(String imagePath) {
    return imagePath.isNotEmpty
        ? Image.asset(
            imagePath,
            fit: BoxFit.contain,
          )
        : Placeholder(); // Placeholder image for empty paths
  }
}

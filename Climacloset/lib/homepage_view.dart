import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/homepage_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class HomepageView extends StatelessWidget {
  HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomepageController controller = Get.put(HomepageController());

    // Call loadData when the view is built
    controller.loadData();
    if (controller.model.assetPathMap.containsKey('hat')) {
      // Image for hat category has been added
      print(
          'Image for hat category has been added: ${controller.model.assetPathMap['hat']}');
    } else {
      print('No image found for hat category');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ClimaCloset',
          style: const TextStyle(
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Change the text color to white
          ),
        ),
        backgroundColor: Color.fromARGB(255, 32, 117, 113), // Change the background color of the app bar
        elevation: 0, // Remove the shadow below the app bar

        actions: [
          // Add refresh button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call loadData again when refresh button is pressed
              controller.loadData();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Open file picker to select and add image
              _pickAndAddImage(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/background_image.jpg",
                ), // Replace "assets/background_image.jpg" with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background
          Obx(() {
            if (controller.model.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    // Display Temperature
                    Stack(
                      children: [
                        // Your image
                        Image.asset(
                          'assets/cloud.jpg',
                          fit: BoxFit.cover,
                        ),
                        // Overlaying text
                        Positioned(
                          top: 50,
                          left: (MediaQuery.of(context).size.width - 315) / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'FASHION FORECAST',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 32, 117, 113),
                                ),
                              ),
                              SizedBox(height: 5),
                              Obx(() => Text(
                                    'Temperature: ${controller.model.temperature.value}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  )),
                              Obx(() => Text(
                                    'Humidity: ${controller.model.humidity.value}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  )),
                              Obx(() => Text(
                                    'Weather Variance: ${controller.model.airPressure.value}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Based off the weather, this outfit suits your needs:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Display Clothing Items in a Vertical List
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: _buildClothingItem(
                            imagePath: controller.model.hatPath.value.isNotEmpty
                                ? controller.model.hatPath.value
                                : controller.model.nohatPath.value,
                          ),
                        ),
                        SizedBox(
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: _buildClothingItem(
                            imagePath:
                                controller.model.coldtopPath.value.isNotEmpty
                                    ? controller.model.coldtopPath.value
                                    : controller.model.hottopPath.value,
                          ),
                        ),
                        SizedBox(
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: _buildClothingItem(
                            imagePath:
                                controller.model.pufferPath.value.isNotEmpty
                                    ? controller.model.pufferPath.value
                                    : controller.model.nopufferPath.value,
                          ),
                        ),
                        SizedBox(
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: _buildClothingItem(
                            imagePath:
                                controller.model.hotbottomPath.value.isNotEmpty
                                    ? controller.model.hotbottomPath.value
                                    : controller.model.coldbottomPath.value,
                          ),
                        ),
                        SizedBox(
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          child: _buildClothingItem(
                            imagePath:
                                controller.model.hotshoesPath.value.isNotEmpty
                                    ? controller.model.hotshoesPath.value
                                    : controller.model.coldshoesPath.value,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildClothingItem({required String imagePath}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ));
  }

  Future<void> addImageToPubspec(String imagePath) async {
    // Read the current content of the pubspec.yaml file
    var file = File('pubspec.yaml');
    var lines = await file.readAsLines();

    // Find the index of the assets section in the pubspec.yaml content
    var assetsIndex = lines.indexWhere((line) => line.trim() == 'assets:');
    if (assetsIndex != -1) {
      // Check if the image path already exists in the assets section
      var imagePathInAssets =
          lines.indexWhere((line) => line.trim() == '- $imagePath');
      if (imagePathInAssets == -1) {
        // Add the new image path to the assets section
        lines.insert(assetsIndex + 1, '  - $imagePath');

        // Write the updated content back to the pubspec.yaml file
        await file.writeAsString(lines.join('\n'));
        print('Image path added to pubspec.yaml: $imagePath');
      } else {
        print('Image path already exists in pubspec.yaml: $imagePath');
      }
    } else {
      print('assets section not found in pubspec.yaml');
    }
  }

  Future<void> _pickAndAddImage(BuildContext context) async {
    final HomepageController controller = Get.find<HomepageController>();
    // Pick an image from device
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      // Show dialog to select category
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: DropdownButton<String>(
                  value: 'hat', // Default category
                  items: [
                    // Add dropdown or radio buttons to select category
                    // For simplicity, using a dropdown with hardcoded categories
                    DropdownMenuItem(
                      child: const Text('Hat'),
                      value: 'hat',
                    ),
                    DropdownMenuItem(
                      child: const Text('Cold Top'),
                      value: 'coldtop',
                    ),
                    DropdownMenuItem(
                      child: const Text('Jacket'),
                      value: 'puffer',
                    ),
                    DropdownMenuItem(
                      child: const Text('Hot Top'),
                      value: 'hottop',
                    ),
                    DropdownMenuItem(
                      child: const Text('Cold Bottom'),
                      value: 'coldbottom',
                    ),
                    DropdownMenuItem(
                      child: const Text('Hot Bottom'),
                      value: 'hotbottom',
                    ),
                    DropdownMenuItem(
                      child: const Text('Cold Shoes'),
                      value: 'coldshoes',
                    ),
                    DropdownMenuItem(
                      child: const Text('Hot Shoes'),
                      value: 'hotshoes',
                    ),
                  ],
                  onChanged: (String? value) async {
                    if (value != null) {
                      // Check if value is not null
                      // Move the selected image file to the assets folder
                      String? imagePath = result.files.first.path;
                      String? assetPath = imagePath != null
                          ? await controller.addImageToAssets(imagePath)
                          : null;
                      if (assetPath != null) {
                        // Call addImageToPubspec to add the new image path to pubspec.yaml
                        await addImageToPubspec(assetPath);

                        // Update the assetPathMap with the new image path
                        //controller.addImageToCategory(assetPath, value);
                      }
                    }
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

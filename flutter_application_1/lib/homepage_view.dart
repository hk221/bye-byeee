import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/homepage_controller.dart';

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
        title: Text('ClimaCloset'),
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
                    "assets/background_image.jpg"), // Replace "assets/background_image.jpg" with your image path
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
                    // Display Clothing Items and Temperature in a Table
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            // Display Hat or Jacket
                            Container(
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
                            // Display Temperature
                            Stack(
                              children: [
                                // Your image
                                Image.asset(
                                  'assets/cloud.jpg',
                                  fit:
                                      BoxFit.cover, // Adjust this to your needs
                                ),
                                // Overlaying text
                                Positioned(
                                  top: 20, // Adjust position vertically
                                  left: (MediaQuery.of(context).size.width -
                                          375) /
                                      2, // Center horizontally // Adjust position horizontally
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'FASHION FORECAST',
                                        style: const TextStyle(
                                          fontFamily:
                                              'Poppins', // Set font family
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              14, // Adjust font size as needed
                                          color:
                                              Colors.blue, // Adjust text color
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              5), // Adjust spacing between text elements
                                      Text(
                                        'Temperature: ${controller.model.temperature.value}',
                                        style: const TextStyle(
                                          fontFamily:
                                              'Poppins', // Set font family
                                          fontSize:
                                              16, // Adjust font size as needed
                                          color:
                                              Colors.black, // Adjust text color
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            // Display Cold Top
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                controller.model.coldtopPath.value.isNotEmpty
                                    ? controller.model.coldtopPath.value
                                    : controller.model.hottopPath.value,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Empty cell for alignment
                            SizedBox(),
                          ],
                        ),
                        TableRow(
                          children: [
                            // Display Hot Bottom or Cold Bottom
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                controller.model.hotbottomPath.value.isNotEmpty
                                    ? controller.model.hotbottomPath.value
                                    : controller.model.coldbottomPath.value,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Empty cell for alignment
                            SizedBox(),
                          ],
                        ),
                        TableRow(
                          children: [
                            // Display Hot Shoes or Cold Shoes
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                controller.model.hotshoesPath.value.isNotEmpty
                                    ? controller.model.hotshoesPath.value
                                    : controller.model.coldshoesPath.value,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Empty cell for alignment
                            SizedBox(),
                          ],
                        ),
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
                        // Update the assetPathMap with the new image path
                        controller.addImageToCategory(assetPath, value);
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

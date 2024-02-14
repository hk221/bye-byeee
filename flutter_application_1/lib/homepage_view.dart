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
                                  left: 20, // Adjust position horizontally
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sensor Readings',
                                        style: const TextStyle(
                                          fontFamily:
                                              'Poppins', // Set font family
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              18, // Adjust font size as needed
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
                                              Colors.blue, // Adjust text color
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
                                    : controller.model.jacketPath.value,
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
}

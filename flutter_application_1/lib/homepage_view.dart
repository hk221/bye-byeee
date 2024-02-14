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
                          height: 200, // Adjust height as needed
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sensor Readings',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Temperature: ${controller.model.temperature.value}'),
                            ],
                          ),
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
    );
  }
}

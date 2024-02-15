import 'dart:async';
import 'package:flutter_application_1/homepage_model.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class HomepageController extends GetxController {
  final HomepageModel model = HomepageModel();
  late MqttServerClient client;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    // Start the initial load data process
    loadData();
    // Start the periodic resubscription timer
    _startResubscriptionTimer();
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the timer when the controller is closed
    _timer.cancel();
  }

  // Method to start the periodic resubscription timer
  void _startResubscriptionTimer() {
    const duration =
        const Duration(seconds: 30); // Set the duration to 30 seconds
    _timer = Timer.periodic(duration, (_) {
      // Call the connectToBroker method to resubscribe every 30 seconds
      connectToBroker();
    });
  }

  Future<void> loadData() async {
    model.isLoading.value = true;
    await connectToBroker();
  }

  Future<void> connectToBroker() async {
    client = MqttServerClient('mqtt-dashboard.com', 'myclientid2');
    client.logging(on: true);

    try {
      await client.connect();
      print('Connected to MQTT broker');

      client.subscribe('IC.embedded/byebye/', MqttQos.atMostOnce);
      print('Subscribed to topic IC.embedded/byebye/');

      client.updates?.listen(_onMessageReceived);
    } catch (e) {
      print('Error connecting to MQTT broker: $e');
    }
  }

  void _onMessageReceived(List<MqttReceivedMessage<MqttMessage>> messages) {
    final MqttPublishMessage message =
        messages[0].payload as MqttPublishMessage;
    final String payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    print('Received message: $payload');

    try {
      if (payload != null && payload.isNotEmpty) {
        Map<String, dynamic> decodedData = decodeJson(payload);
        if (decodedData != null && decodedData.isNotEmpty) {
          List<String> clothingItems = decodedData.keys.toList();
          double temperature =
              double.parse(decodedData['temperature'].toString());
          double humidity = double.parse(
              decodedData['humidity'].toString()); // Add humidity parsing
          model.setData(clothingItems,
              temperature: temperature,
              humidity: humidity); // Pass humidity to setData
        } else {
          print('Error: Empty or null decoded data');
        }
      } else {
        print('Error: Empty or null payload received');
      }
    } catch (e) {
      print('Error parsing data: $e');
    } finally {
      disconnectFromBroker();
      print('Disconnected from broker');
    }
  }

  Map<String, dynamic> decodeJson(String payload) {
    try {
      var data = jsonDecode(payload);
      if (data != null && data is Map<String, dynamic>) {
        double temperature =
            double.tryParse(data['temperature'].toString()) ?? 0.0;
        double humidity = double.tryParse(data['humidity'].toString()) ?? 0.0;
        List<String> clothingItems = data.values.cast<String>().toList();
        print('Temperature: $temperature');
        print('Humidity: $humidity');
        print(clothingItems);
        return data; // Return the decoded data map
      } else {
        throw FormatException('Invalid JSON format');
      }
    } catch (e) {
      print('Error decoding JSON: $e');
      return {}; // Return an empty map in case of error
    }
  }

  void disconnectFromBroker() {
    model.isLoading.value = false;
    client.disconnect();
    print('Disconnected from MQTT broker');
  }

  void resetData() {
    model.isLoading.value = true;
    model.reset();
    connectToBroker();
    model.isLoading.value = false;
  }

  // Method to handle picking and adding image, accepts a callback for UI-related tasks
  Future<void> pickAndAddImage(
      Function(String, String) addImageCallback) async {
    // Pick an image from device
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      // Invoke the callback function with the image path and default category
      addImageCallback(result.files.first.path ?? "", "hat");
    }
  }

  Future<String?> addImageToAssets(String imagePath) async {
    // Move the selected image file to the assets folder
    String? assetPath = await moveFileToAssets(imagePath);
    return assetPath;
  }

  Future<String?> moveFileToAssets(String filePath) async {
    try {
      // Specify the destination directory within the assets folder
      Directory destinationDirectory =
          Directory('assets');
      // Create the directory if it doesn't exist
      if (!await destinationDirectory.exists()) {
        await destinationDirectory.create(recursive: true);
      }

      // Specify the destination path within the assets folder
      String destinationPath = 'assets/new_image.png';

      // Create a File object for the source file
      File sourceFile = File(filePath);

      // Create a File object for the destination file
      File destinationFile = File(destinationPath);

      // Move the file to the destination
      await sourceFile.copy(destinationPath);

      // Return the destination path
      return destinationPath;
    } catch (e) {
      print('Error moving file: $e');
      return null;
    }
  }

  void addImageToCategory(String imagePath, String category) {
    // Check if the category already exists in the assetPathMap
    if (model.assetPathMap.containsKey(category)) {
      // Category exists, update the image path
      model.assetPathMap[category] = imagePath;
    } else {
      // Category doesn't exist, add a new entry
      model.assetPathMap.addAll({category: imagePath});
    }
  }
}

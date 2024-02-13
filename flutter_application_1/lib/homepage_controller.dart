import 'dart:async'; // Import dart:async for Timer
import 'package:flutter_application_1/homepage_model.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomepageController extends GetxController {
  final HomepageModel model = HomepageModel();
  late MqttServerClient client;
  late Timer _timer; // Add a Timer variable

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
        // Ensure that the payload is explicitly typed as a list of strings
        List<String> clothingItems = decodeJson(payload);
        model.setData(
            clothingItems, model.assetPathMap); // Pass assetPathMap to setData
      } else {
        print('Error: Empty or null payload received');
      }
    } catch (e) {
      print('Error parsing data: $e');
    } finally {
      // Disconnect from the broker after processing the message
      disconnectFromBroker();
      print('Disconnected from broker');
    }
  }

  List<String> decodeJson(String payload) {
    try {
      var data = jsonDecode(payload);
      if (data != null && data is Map<String, dynamic>) {
        List<String> clothingItems = data.values.cast<String>().toList();
        print(clothingItems);
        return clothingItems;
      } else {
        throw FormatException('Invalid JSON format');
      }
    } catch (e) {
      print('Error decoding JSON: $e');
      return [];
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
}

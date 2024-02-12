import 'package:flutter_application_1/homepage_model.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomepageController extends GetxController {
  final HomepageModel model = HomepageModel();
  late MqttServerClient client;

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
        List<String> clothingItems = decodeJson(payload);
        model.setData(clothingItems);
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
    client.disconnect();
    print('Disconnected from MQTT broker');
    model.isLoading.value = false;

  }

  void resetData() {
    model.isLoading.value = true;
    model.reset();
    connectToBroker();
    model.isLoading.value = false;
  }
}

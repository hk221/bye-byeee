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
    client.logging(on: true);
    print('Received message: $payload');

    try {
      List<String> clothingItems = decodeJson(payload);
      model.setData(clothingItems);
    } catch (e) {
      print('Error parsing data: $e');
    } finally {
      disconnectFromBroker();
    }
  }

  List<String> decodeJson(String payload) {
    var data = jsonDecode(payload);
    List<String> clothingItems = List<String>.from(data['clothingItems']);
    print(clothingItems);
    return clothingItems;
  }

  void disconnectFromBroker() {
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

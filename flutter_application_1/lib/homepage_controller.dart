import 'package:flutter_application_1/homepage_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';

class HomepageController {
  final HomepageModel model = HomepageModel();

  Future<void> loadData() async {
    model.isLoading.value = true;

    // Connect to the MQTT broker
    final mqttClient = MqttClient('your_mqtt_broker_url',
        ''); // Replace 'your_mqtt_broker_url' with the address of your Mosquitto broker
    mqttClient.port = 1883; // Default MQTT port
    mqttClient.keepAlivePeriod = 30; // Keep alive period in seconds

    // Listen for messages
    final clientEvent = mqttClient.updates;
    clientEvent?.listen((List<MqttReceivedMessage<MqttMessage>>? event) {
      // Ensure event is not null before accessing its elements
      if (event != null && event.isNotEmpty) {
        final MqttPublishMessage receivedMessage =
            event[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
            receivedMessage.payload.message);
        print('Received message: $payload');

        // Parse received data and update the model
        try {
          var data = jsonDecode(payload);
          List<String> clothingItems = List<String>.from(data['clothingItems']);
          model.setData(clothingItems);
        } catch (e) {
          print('Error parsing data: $e');
        }
      }
    });

    // Connect to the MQTT broker and subscribe to the topic
    await mqttClient.connect();
    mqttClient.subscribe('temperature', MqttQos.atMostOnce);

    // Set isLoading to false after data is loaded
    model.isLoading.value = false;
  }

  // Method to reset data by calling loadData
  void resetData() {
    loadData();
  }
}



/*import 'package:flutter_application_1/homepage_model.dart';

class HomepageController {
  final HomepageModel model = HomepageModel();

  Future<void> loadData() async {
    model.isLoading.value = true;
    
    // Simulate fetching data from a server
    List<String> clothingItems = ['hat', 'jacket', 'top', 'bottom'];
    
    // Set data in the model
    model.setData(clothingItems);
    
    model.isLoading.value = false;
  }
}
}*/

/*import 'package:flutter_application_1/homepage_model.dart';

class HomepageController {
  final HomepageModel model = HomepageModel();

  Future<void> loadData() async {
    model.isLoading.value = true;
    
    //model.setData(hat, jacket, top, bottom)
    model.isLoading.value = false;
  }
}*/


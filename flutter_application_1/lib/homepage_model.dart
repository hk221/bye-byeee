import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomepageModel {
  // Map to store asset paths for each clothing item
  Map<String, String> assetPathMap = {
    'hat': 'assets/woolyhat.png',
    'hottop': 'assets/hoodie.png',
    'coldtop': 'assets/tshirt.png',
    'hotbottom': 'assets/trousers.png',
    'coldbottom': 'assets/shorts.png',
    'hotshoes': 'assets/trainers.png',
    'coldshoes': 'assets/flipflops.png',
    'nohat': 'assets/nohat.png',
  };

  // RxStrings to store asset paths for each clothing item
  late RxString hatPath;
  late RxString hottopPath;
  late RxString coldtopPath;
  late RxString hotbottomPath;
  late RxString coldbottomPath;
  late RxString hotshoesPath;
  late RxString coldshoesPath;
  late RxString nohatPath;

  late RxDouble temperature;
  late RxDouble humidity;

  RxBool isLoading = true.obs;

  HomepageModel() {
    // Initialize RxStrings
    hatPath = ''.obs;
    hottopPath = ''.obs;
    coldtopPath = ''.obs;
    hotbottomPath = ''.obs;
    coldbottomPath = ''.obs;
    hotshoesPath = ''.obs;
    coldshoesPath = ''.obs;
    nohatPath = ''.obs;
    temperature = 0.0.obs;
    humidity = 0.0.obs;
  }

  void reset() {
    hatPath.value = '';
    hottopPath.value = '';
    coldtopPath.value = '';
    hotbottomPath.value = '';
    coldbottomPath.value = '';
    hotshoesPath.value = '';
    coldshoesPath.value = '';
    nohatPath.value = '';
    temperature.value = 0.0;
    humidity.value = 0.0;
  }

  // Method to set data for clothing items
  void setData(List<String> clothingItems,
      {double temperature = 0.0, double humidity = 0.0}) {
    // Reset previous data
    reset();

    // Assign asset paths based on the provided clothing items
    for (var item in clothingItems) {
      if (assetPathMap.containsKey(item)) {
        switch (item) {
          case 'hat':
            hatPath.value = assetPathMap[item]!;
            break;
          case 'hottop':
            hottopPath.value = assetPathMap[item]!;
            break;
          case 'coldtop':
            coldtopPath.value = assetPathMap[item]!;
            break;
          case 'hotbottom':
            hotbottomPath.value = assetPathMap[item]!;
            break;
          case 'coldbottom':
            coldbottomPath.value = assetPathMap[item]!;
            break;
          case 'hotshoes':
            hotshoesPath.value = assetPathMap[item]!;
            break;
          case 'coldshoes':
            coldshoesPath.value = assetPathMap[item]!;
            break;
          case 'nohat': // Handle the 'nohat' case
            nohatPath.value = assetPathMap[item]!;
            break;
        }
      }
    }
    // Update temperature and humidity
    this.temperature.value = temperature;
    this.humidity.value = humidity;
  }
}

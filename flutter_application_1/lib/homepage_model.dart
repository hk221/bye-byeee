import 'package:get/get.dart';

class HomepageModel {
  Map<String, String> assetPathMap = {
    'hat': 'assets/woolyhat.png',
    'jacket': 'assets/hoodie.png',
    'coldtop': 'assets/tshirt.png',
    'hot_bottom': 'assets/trousers.png',
    'cold_bottom': 'assets/shorts.png',
    'hot_shoes': 'assets/trainers.png',
    'cold_shoes': 'assets/flipflops.png',
  };

  List<String> clothingItems = [];

  RxBool isLoading = true.obs;

  void reset() {
    clothingItems.clear();
  }

  // Method to set data for clothing items
  void setData(List<String> items) {
    // Reset previous data
    reset();

    // Add new clothing items
    clothingItems.addAll(items);
  }
}

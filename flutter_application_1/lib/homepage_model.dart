import 'package:get/get.dart';

class HomepageModel {
  // Map to store asset paths for each clothing item
  Map<String, String> assetPathMap = {
    'hat': 'assets/woolyhat.png',
    'jacket': 'assets/hoodie.png',
    'coldtop': 'assets/tshirt.png',
    'hot_bottom': 'assets/trousers.png',
    'cold_bottom': 'assets/shorts.png',
    'hot_shoes': 'assets/trainers.png',
    'cold_shoes': 'assets/flipflops.png',
  };

  // RxStrings to store asset paths for each clothing item
  late RxString hatPath;
  late RxString jacketPath;
  late RxString coldtopPath;
  late RxString hot_bottomPath;
  late RxString coldbottomPath;
  late RxString hot_shoesPath;
  late RxString coldshoesPath;

  RxBool isLoading = true.obs;

  HomepageModel() {
    // Initialize RxStrings
    hatPath = ''.obs;
    jacketPath = ''.obs;
    coldtopPath = ''.obs;
    hot_bottomPath = ''.obs;
    coldbottomPath = ''.obs;
    hot_shoesPath = ''.obs;
    coldshoesPath = ''.obs;
  }
  List<String> clothingItems = [];
  void reset() {
    clothingItems.clear();
  }

  // Method to set data for clothing items
  // Method to set data for clothing items
  void setData(List<String> clothingItems) {
    // Reset all paths
    hatPath.value = '';
    jacketPath.value = '';
    coldtopPath.value = '';
    hot_bottomPath.value = '';
    coldbottomPath.value = '';
    hot_shoesPath.value = '';
    coldshoesPath.value = '';

    // Assign asset paths based on the provided list of clothing items
    for (var item in clothingItems) {
      if (assetPathMap.containsKey(item)) {
        switch (item) {
          case 'hat':
            hatPath.value = assetPathMap[item]!;
            break;
          case 'jacket':
            jacketPath.value = assetPathMap[item]!;
            break;
          case 'coldtop':
            coldtopPath.value = assetPathMap[item]!;
            break;
          case 'hot_bottom':
            hot_bottomPath.value = assetPathMap[item]!;
            break;
          case 'cold_bottom':
            coldbottomPath.value = assetPathMap[item]!;
            break;
          case 'hot_shoes':
            hot_shoesPath.value = assetPathMap[item]!;
            break;
          case 'cold_shoes':
            coldshoesPath.value = assetPathMap[item]!;
            break;
        }
      }
    }

    // Log the assigned paths for debugging
    print('Hat Path: ${hatPath.value}');
    print('Jacket Path: ${jacketPath.value}');
    print('Cold Top Path: ${coldtopPath.value}');
    print('Hot Bottom Path: ${hot_bottomPath.value}');
    print('Cold Bottom Path: ${coldbottomPath.value}');
    print('Hot Shoes Path: ${hot_shoesPath.value}');
    print('Cold Shoes Path: ${coldshoesPath.value}');
    
  }

}

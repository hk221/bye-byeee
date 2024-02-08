import 'package:get/get.dart';

class HomepageModel {
  // Map to store asset paths for each clothing item
  Map<String, String> assetPathMap = {
    'hat': 'assets/wooly_hat.png',
    'jacket': 'assets/hoodie.png',
    'cold_top': 'assets/tshirt.png',
    'hot_bottom': 'assets/trousers.png',
    'cold_bottom': 'assets/shorts.png',
    'hot_shoes': 'assets/trainers.png',
    'cold_shoes': 'assets/flip_flops.png',
  };

  // RxStrings to store asset paths for each clothing item
  late RxString hatPath;
  late RxString jacketPath;
  late RxString coldtopPath;
  late RxString hotbottomPath;
  late RxString coldbottomPath;
  late RxString hotshoesPath;
  late RxString coldshoesPath;

  RxBool isLoading = true.obs;

  // Method to set data for clothing items
  void setData(List<String> clothingItems) {
    // Clear all paths first
    hatPath.value = '';
    jacketPath.value = '';
    coldtopPath.value = '';
    hotbottomPath.value = '';
    coldbottomPath.value = '';
    hotshoesPath.value = '';
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
          case 'cold_top':
            coldtopPath.value = assetPathMap[item]!;
            break;
          case 'hot_bottom':
            hotbottomPath.value = assetPathMap[item]!;
            break;
          case 'cold_bottom':
            coldbottomPath.value = assetPathMap[item]!;
            break;
          case 'hot_shoes':
            hotshoesPath.value = assetPathMap[item]!;
            break;
          case 'cold_shoes':
            coldshoesPath.value = assetPathMap[item]!;
            break;
        }
      }
    }
  }
}

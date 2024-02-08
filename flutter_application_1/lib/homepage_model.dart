import 'package:get/get.dart';

class HomepageModel {
  // Map to store asset paths for each clothing item
  Map<String, String> assetPathMap = {
    'hat': 'assets/wooly_hat.png',
    'jacket': 'assets/hoodie.png',
    'top': 'assets/tshirt.png',
    'bottom': 'assets/trousers.png',
  };

  // RxStrings to store asset paths for each clothing item
  late RxString hatPath;
  late RxString jacketPath;
  late RxString topPath;
  late RxString bottomPath;

  RxBool isLoading = true.obs;

  // Method to set data for clothing items
  void setData(List<String> clothingItems) {
    // Assign asset paths based on the provided list of clothing items
    hatPath.value = assetPathMap['hat']!;
    jacketPath.value = assetPathMap['jacket']!;
    topPath.value = assetPathMap['top']!;
    bottomPath.value = assetPathMap['bottom']!;
  }
}

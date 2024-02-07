import 'package:get/get.dart';

class HomepageModel {
  Map<dynamic, String> assetPathMap = Map();

  late RxString hatPath;
  late RxString jacketPath;
  late RxString topPath;
  late RxString bottomPath;

  RxBool isLoading = true.obs;

  void setData(dynamic hat, dynamic jacket, dynamic top, dynamic bottom) {
    hatPath.value = assetPathMap[hat]!;
    jacketPath.value = assetPathMap[jacket]!;
    topPath.value = assetPathMap[top]!;
    bottomPath.value = assetPathMap[bottom]!;
  }
}

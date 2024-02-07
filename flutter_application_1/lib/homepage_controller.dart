import 'package:flutter_application_1/homepage_model.dart';

class HomepageController {
  final HomepageModel model = HomepageModel();

  Future<void> loadData() async {
    model.isLoading.value = true;
    
    //model.setData(hat, jacket, top, bottom)
    model.isLoading.value = false;
  }
}

 
import 'package:get/get.dart';
 import 'package:zeus/features/transactions/deposit_entering_data/platform/choose_platform_model.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_service_model.dart';

class PlatformController extends GetxController {
  final PlatformService _platformService = PlatformService();
  final RxList<Platform> platforms = <Platform>[].obs;
  final RxInt selectedPlatformId = 0.obs; // Store the selected platform ID
  final RxInt selectedPlatformCode = 0.obs; // Store the selected platform ID
  final RxString selectedPlatformName = ''.obs; // Add this line 

  @override
  void onInit() {
    super.onInit();
    fetchPlatforms();
  }

  Future<void> fetchPlatforms() async {
    try {
      platforms.value = await _platformService.getPlatforms();
 
    } catch (e) {
       // Handle the error, e.g., show a snackbar
    }
  }
}
 
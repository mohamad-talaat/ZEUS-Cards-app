  import 'package:get/get.dart';
 
import '../../../dashboard as features/dashboard/dashboard_controller.dart';
import '../../../dashboard as features/transactions/transactions_controller.dart';
 
 
Future<void> updateAppOnSuccess() async {
    final dashboardController = Get.find<DashboardController>();
    final transactionsController = Get.find<TransactionsController>();
    // Run fetchCardData() in the background
    dashboardController.fetchCardData().then((_) {
     // update();
      // Optional: You can call a function to refresh the UI on the
      // Dashboard screen if needed, but it's likely that GetX's reactive
      // features will handle the UI refresh automatically
        dashboardController.update();
        transactionsController.update();
    });
  }
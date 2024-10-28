import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/ui/widget/to_update_balance.dart';
import 'package:zeus/features/transactions/zues%20transfer/logic/data_service.dart';

import '../zues_transfer_model.dart';

class ZeusTransferController extends GetxController {
  final ZeusTransferService zeusTransferService;

  ZeusTransferController({required this.zeusTransferService});

  // final zeusTransferformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> zeusTransferformKey =
      GlobalKey<FormState>(); // Unique Key

  final cardCodeController = TextEditingController();
  final amountController = TextEditingController();
  final cardCodeToSendToController = TextEditingController();
  final selectedCurrency = 'USD'.obs;
  final RxList<String> currencies = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting =
      false.obs; // New flag to prevent double submission

  // Future<void> _updateAppOnSuccess() async {
  //   final dashboardController = Get.find<DashboardController>();
  //   // Run fetchCardData() in the background
  //   dashboardController.fetchCardData().then((_) {
  //    // update();
  //     // Optional: You can call a function to refresh the UI on the
  //     // Dashboard screen if needed, but it's likely that GetX's reactive
  //     // features will handle the UI refresh automatically
  //       dashboardController.update();
  //   });
  // }

  Future<void> submitTransfer() async {
    if (zeusTransferformKey.currentState!.validate() && !isSubmitting.value) {
      try {
        isSubmitting.value = true; // Set flag to prevent double submission
        isLoading.value = true;

        final transferRequest = TransferRequest(
            cardCode: cardCodeToSendToController.text.trim(),
            senderCardCode: cardCodeController.text.trim(),
            amount: amountController.text.trim(),
            currency: "USD" //selectedCurrency.value,
            );

        final response =
            await zeusTransferService.submitTransfer(transferRequest);

        if (response.result) {
          Get.defaultDialog(
            title: "Success",
            middleText:
                "Your internal transfer to ZEUS card coded ${cardCodeToSendToController.text} is under review\nIt may take up to 60 minutes to be confirmed",
            confirm: TextButton(
              onPressed: () async {
                cardCodeController.clear();
                amountController.clear();
                cardCodeToSendToController.clear();

                Get.toNamed(PageName.bottomNavBar);
                // Update data in the background
                await updateAppOnSuccess();
              },
              child: const Text("Ok"),
            ),
          );
        } else {
          // Handle error responses from the API
          final errorMessage = response.msg.isNotEmpty
              ? response.msg
              : 'Failed to process transfer Please check Your Data again';
          Get.snackbar('Error', errorMessage);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to process transfer: ${e.toString()}');
      } finally {
        isLoading.value = false;
        isSubmitting.value = false; // Reset the submission flag
      }
    }
  }

  @override
  void onClose() {
    cardCodeController.dispose();
    amountController.dispose();
    cardCodeToSendToController.dispose();
    super.onClose();
  }
}

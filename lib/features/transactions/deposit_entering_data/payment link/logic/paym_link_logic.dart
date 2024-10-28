import 'package:flutter/material.dart';
 
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
 
import 'package:zeus/features/transactions/deposit_entering_data/payment%20link/logic/pay_link_data_service.dart';

import '../../../../../core/pagescall/pagename.dart';


// Payment_Link_deposit_controller.dart

class PaymentLinkDepositController extends GetxController {
  final PaymentLinkDepositService _service =
      Get.find<PaymentLinkDepositService>();
  final cardCodeController = TextEditingController();
  final amountController =
      TextEditingController(); // You only need these two controllers now
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;

  Future<void> submitDeposit() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Validate card code

        isLoading.value = true;

        bool isValidCardCode =
            await _service.validateCardCode(cardCodeController.text);
        if (!isValidCardCode) {
          Get.snackbar('Error', 'You entered a wrong card code');
          return;
        }

        final response = await _service.requestLinkDeposit(
          cardCodeController.text,
          double.parse(amountController.text),
        );

        if (response.result) {
          Get.defaultDialog(
              titleStyle: AppTextStyle.successWordInmassegeInGetDialog,
              title: "Success",
              confirm: TextButton(
                child: Text(
                  "Ok",
                  style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15),
                ),
                onPressed: () {
                  cardCodeController.clear();
                  amountController.clear();
                  Get.toNamed(PageName.bottomNavBar);
                },
              ),
              content: Text(
                  style: AppTextStyle.paypalRegular11,
                  "Deposit request is submitted\nPlease check your Email in the next 30 minutes to receive the payment link \nPayment link fees: 5%+2EUR \nCredit duration is up to 4 working days"));
        } else {
          Get.snackbar('Error', response.msg);
        }
      } catch (e) {
        Get.snackbar('Error',
            'Failed to submit deposit request: ${e.toString() == "type 'Null' is not a subtype of type 'bool'" ? "Your Card Code Not Found" : "Please Check You Data"}');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    cardCodeController.dispose();
    amountController.dispose();
    super.onClose();
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';

import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:zeus/features/transactions/deposit_entering_data/usdt/logic/dep_via_usdt_data_service.dart';
 
// vodafone_cash_deposit_controller.dart

class USDTDepositController extends GetxController {
  final USDTDepositService _service = Get.find<USDTDepositService>();

  final cardCodeController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final amountController = TextEditingController();
  late var plaformUserIdController = TextEditingController();
  final platformIdController =
      TextEditingController(); // Add controller for platform_id
  final PlatformController platformController = Get.put(PlatformController());

  final formKey = GlobalKey<FormState>();

  final RxString _invoicePath = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString amountControllerr = ''.obs;

  String get invoicePath => _invoicePath.value;
  @override
  void onInit() {
    super.onInit();
    Get.put(PlatformController());
    platformController.fetchPlatforms();
    amountController.addListener(() {
      amountControllerr.value = amountController.text;
    });
  }

  Future<void> pickInvoice() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _invoicePath.value = image.path;
    }
  }

  Future<void> submitDeposit() async {
    if (formKey.currentState!.validate() && invoicePath.isNotEmpty) {
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

        final response = await _service.requestUsdtDeposit(
          cardCodeController.text,
          invoiceNumberController.text,
          double.parse(amountController.text),
          platformIdController.text, // Get platform_id
          platformController.selectedPlatformId.value == 1
              ? "Binance"
              : "Bybit",
          invoicePath,
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
                  invoiceNumberController.clear();
                  amountController.clear();
                  _invoicePath.value = '';
                  Get.toNamed(PageName.bottomNavBar);
                },
              ),
              content: Text(
                  style: AppTextStyle.paypalRegular11,
                  "Deposit transaction is pending \nConversion rate 1 USDT= 0.92\$ \nDeposit fees: 5% \nCredit duration is up to 1 working day"));
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
    invoiceNumberController.dispose();
    amountController.dispose();
    super.onClose();
  }
}


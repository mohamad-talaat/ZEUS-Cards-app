import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/transactions/deposit_entering_data/vodafone/logic/dep_voda_data_service.dart';

// vodafone_cash_deposit_controller.dart

class VodafoneCashDepositController extends GetxController {
  final VodafoneCashDepositService _service =
      Get.find<VodafoneCashDepositService>();

  final cardCodeController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final amountController = TextEditingController();
  final finalAmountController = TextEditingController();
  final RxDouble calculatedAmount = 0.0.obs;
  final RxString amountControllerr = ''.obs;
  final RxDouble depositRate = 0.0.obs;

  final formKey = GlobalKey<FormState>();
  void updateCalculatedAmount() async {
    double amount = double.tryParse(amountController.text) ?? 0;
    Map<String, dynamic> data = await getDepositAndWithdraw();
    double deposit = data['deposit']!.toDouble();
    calculatedAmount.value =
        (amount * deposit) + ((amount * deposit) * (8 / 100));
  }

  @override
  void onInit() {
    super.onInit();
    amountController.addListener(updateCalculatedAmount);
    amountController.addListener(() {
      amountControllerr.value = amountController.text;
    });
    loadDepositRate();
  }

  Future<void> loadDepositRate() async {
    Map<String, dynamic> data = await getDepositAndWithdraw();
    depositRate.value = (data['deposit'] as num).toDouble();
  }

  Future<Map<String, dynamic>> getDepositAndWithdraw() async {
    try {
      final response = await http.get(Uri.parse(
          "https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/calculators"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final deposit = data['data']['calculator']['deposit'];
        //  final withdraw = data['data']['calculator']['withdraw'];

        return {'deposit': deposit};
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      ('Error fetching data: $error');
      return {};
    }
  }

  final RxString _invoicePath = ''.obs;
  final RxBool isLoading = false.obs;

  String get invoicePath => _invoicePath.value;

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

        final response = await _service.requestDeposit(
          cardCodeController.text,
          invoiceNumberController.text,
          double.parse(amountController.text),
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
                  "Deposit transaction is pending \nDeposit fees: 8% \nCredit duration is up to 1 working day  "));
        } else {
          Get.snackbar('Error', response.msg);
        }
      } catch (e) {
        ("qqqqqqqqqqqqqqqqqqqqqqqqq ${e.toString()}");
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

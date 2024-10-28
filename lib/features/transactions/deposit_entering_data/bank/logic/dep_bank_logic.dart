import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/full_auth/logic/auth/login_controller_with_otp.dart';
import 'package:zeus/features/transactions/deposit_entering_data/bank/logic/dep_bank_data_service.dart';

// vodafone_cash_deposit_controller.dart
class BankDepositController extends GetxController {
  final BankDepositService _service = Get.find<BankDepositService>();

  final cardCodeController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final amountController = TextEditingController();
  final platformIdController = TextEditingController();
  final Rx<Map<String, dynamic>> cardData = Rx<Map<String, dynamic>>({});
  final RxString amountControllerr = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCardData();
    amountController.addListener(() {
      amountControllerr.value = amountController.text;
    });
  }

  final formKey = GlobalKey<FormState>();

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

        final response = await _service.requestBankDeposit(
          cardCodeController.text,
          invoiceNumberController.text,
          double.parse(amountController.text),
          platformIdController.text, // Get platform_id
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
                  platformIdController.clear();
                  amountController.clear();
                  _invoicePath.value = '';
                  Get.toNamed(PageName.bottomNavBar);
                },
              ),
              content: Text(
                  style: AppTextStyle.paypalRegular11,
                  "Deposit transaction is pending \nDeposit fees: 2% \nCredit duration 3-5 working days  "));
        } else {
          Get.snackbar('Error', response.msg);
        }
      } catch (e) {
        (e.toString());

        Get.snackbar('Error',
            'Failed to submit deposit request: ${e.toString() == "type 'Null' is not a subtype of type 'bool'" ? "Your Card Code Not Found" : "Please Check You Data"}');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> fetchCardData() async {
    try {
      String? token = await storage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(
            'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/getcards'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data') &&
            responseData['data'] is Map &&
            responseData['data'].containsKey('cards') &&
            responseData['data']['cards'] is List &&
            responseData['data']['cards'].isNotEmpty) {
          cardData.value = responseData['data']['cards'][0];
        }
      } else {
        throw Exception('Failed to load card data');
      }
    } catch (e) {
      ('Error fetching card data: $e');
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

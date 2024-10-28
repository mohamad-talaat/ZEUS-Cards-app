import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';

import 'package:http/http.dart' as http;
import 'package:zeus/features/dashboard/ui/widget/to_update_balance.dart';
import 'dart:convert';

import 'package:zeus/features/transactions/withdraw_entering_data/vodafone/logic/vod_with_data_service.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/vodafone/vod_with_model.dart';

class VodafoneCashwithdrawController extends GetxController {
  final WithdrawVodafoneCashService withdrawVodafoneCashService =
      Get.find<WithdrawVodafoneCashService>();
  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  final cardCodeController = TextEditingController();
  final amountController = TextEditingController();
  final amountEGPController = TextEditingController();
  final vodafoneNumberController = TextEditingController();
  final RxDouble calculatedAmount = 0.0.obs;
  final RxDouble withdrawRate = 0.0.obs;

  void updateCalculatedAmount() async {
    double amount = double.tryParse(amountController.text) ?? 0;
    Map<String, dynamic> data = await getDepositAndWithdraw();
    double withdraw = data['withdraw']!.toDouble() ?? 1;
    calculatedAmount.value = amount * withdraw;
  }

  @override
  void onInit() {
    super.onInit();
    amountController.addListener(updateCalculatedAmount);
    loadwithdrawRate();
  }

  Future<void> loadwithdrawRate() async {
    Map<String, dynamic> data = await getDepositAndWithdraw();
    withdrawRate.value = (data['withdraw'] as num).toDouble();
  }

  Future<void> submitVodafoneCashwithdraw() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final request = VodafoneCashWithdrawRequest(
          cardCode: cardCodeController.text.trim(),
          price: amountController.text.trim(),
          vodafoneCashNum: vodafoneNumberController.text.trim(),
        );

        final response = await withdrawVodafoneCashService
            .submitVodafoneCashWithdraw(request);

        if (response.result) {
          Get.defaultDialog(
            titleStyle: AppTextStyle.successWordInmassegeInGetDialog,
            title: "Success",
            confirm: TextButton(
              onPressed: () async {
                // Clear the form fields after successful submission
                cardCodeController.clear();
                amountController.clear();
                amountEGPController.clear();
                vodafoneNumberController.clear();
                Get.toNamed(PageName.bottomNavBar);
                // Update data in the background
                await updateAppOnSuccess();
              },
              child: Text(
                "Ok",
                style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15),
              ),
            ),
            content: Text(
                style: AppTextStyle.paypalRegular11,
                "Withdrawal transaction is processing\nWithdrawal fees: %0\nCredit duration is up to 3 working days"),
          );
        } else {
          Get.snackbar('Error', response.msg);
        }
      } catch (e) {
        ("qqqqqqqqqqqqqqqqqqqqqqqqq ${e.toString()}");

        Get.snackbar('Error',
            'Failed to submit Vodafone Cash withdrawal: ${e.toString() == "type 'Null' is not a subtype of type 'bool'" ? "\n1-Your Card Code Not Found \n 2-check Your balance" : "Please Check You Data"}');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    cardCodeController.dispose();
    amountController.dispose();

    vodafoneNumberController.dispose();
    super.onClose();
  }
}

Future<Map<String, dynamic>> getDepositAndWithdraw() async {
  try {
    final response = await http.get(Uri.parse(
        "https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/calculators"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final withdraw = data['data']['calculator']['withdraw'];

      return {'withdraw': withdraw};
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    ('Error fetching data: $error');
    return {};
  }
}

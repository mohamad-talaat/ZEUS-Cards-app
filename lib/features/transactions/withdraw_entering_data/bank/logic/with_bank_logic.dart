import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/ui/widget/to_update_balance.dart';

import 'package:zeus/features/full_auth/logic/auth/login_controller_with_otp.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/bank/with_bank_model.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/bank/logic/with_bank_service.dart';

class WithdrawController extends GetxController {
  final WithdrawService _withdrawService = Get.find<WithdrawService>();
  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  // Text Editing Controllers
  final cardCodeController = TextEditingController();
  final RxString selectedWithdrawType = 'SWIFT'.obs;
  final amountController = TextEditingController();
  final accountNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final recAddressCityController = TextEditingController();
  final recAddressStreetController = TextEditingController();
  final recAddressBuildingController = TextEditingController();

  // For SWIFT, SEPA Instant, or SEPA
  final ibanController = TextEditingController();
  final swiftCodeController = TextEditingController();

  // For ACH Routing
  final routingNumController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankAddressCityController = TextEditingController();
  final bankAddressStreetController = TextEditingController();
  final bankAddressBuildingController = TextEditingController();

  final RxList<Map<String, dynamic>> currencies = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> countries = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> cardCode = <Map<String, dynamic>>[].obs;
  final Rx<String?> selectedcardCode = ''.obs;
  final Rx<String?> selectedCurrency = ''.obs;
  final Rx<String?> selectedCountry = ''.obs;

  // Dropdown for Bank Withdraw Type
  final List<String> withdrawTypes = [
    'SWIFT',
    'SEPA',
    'SEPA Instant',
    'ACH Routing',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();
    fetchCountries();
  }

  Future<void> fetchCurrencies() async {
    try {
      String? token = await storage.read(key: 'auth_token');

      final response = await http.get(
          Uri.parse(
              'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-all-currencies'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          currencies.value = List<Map<String, dynamic>>.from(jsonData['data']);
          if (currencies.isNotEmpty) {
            // Set the default selected currency
            selectedCurrency.value = currencies[0]['code'];
          }
          update(); // Update the UI after fetching currencies
        }
      }
    } catch (e) {
      ('Error fetching currencies: $e');
    }
  }

  Future<void> fetchCountries() async {
    try {
      String? token = await storage.read(key: 'auth_token');

      final response = await http.get(
          Uri.parse(
              'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-all-countries'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        countries.value = List<Map<String, dynamic>>.from(jsonData['data']);
        if (countries.isNotEmpty) {
          // Set the default selected country
          selectedCountry.value = countries[0]['name'];
        }
        update(); // Update the UI after fetching countries
      }
    } catch (e) {
      ('Error fetching countries: $e');
    }
  }

  Future<void> submitBankTransfer() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final request = BankWithdrawRequest(
          cardCode: cardCodeController.text.trim(),
          bankWithdrawType: selectedWithdrawType.value,
          price: amountController.text.trim(),
          bankCurrency: selectedCurrency.value ?? '',
          accountNum: accountNumberController.text.trim(),
          recAddressCity: recAddressCityController.text.trim(),
          recAddressStreet: recAddressStreetController.text.trim(),
          recAddressBuilding: recAddressBuildingController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          iban: ibanController.text.trim(),
          swiftCode: swiftCodeController.text.trim(),
          countryOfBank: selectedCountry.value,
          routingNum: routingNumController.text.trim(),
          bankName: bankNameController.text.trim(),
          bankAddressCity: bankAddressCityController.text.trim(),
          bankAddressStreet: bankAddressStreetController.text.trim(),
          bankAddressBuilding: bankAddressBuildingController.text.trim(),
        );

        final response = await _withdrawService.submitBankTransfer(request);

        if (response.result) {
          Get.defaultDialog(
            titleStyle: AppTextStyle.successWordInmassegeInGetDialog,
            title: "Success",
            confirm: TextButton(
              child: Text(
                "Ok",
                style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15),
              ),
              onPressed: () async {
                // Clear all fields
                cardCodeController.clear();
                amountController.clear();
                accountNumberController.clear();
                firstNameController.clear();
                lastNameController.clear();
                recAddressCityController.clear();
                recAddressStreetController.clear();
                recAddressBuildingController.clear();
                ibanController.clear();
                swiftCodeController.clear();
                routingNumController.clear();
                bankNameController.clear();
                bankAddressCityController.clear();
                bankAddressStreetController.clear();
                bankAddressBuildingController.clear();
                Get.toNamed(PageName.bottomNavBar);
                // Update data in the background
                await updateAppOnSuccess();
              },
            ),
            content: Text(
              style: AppTextStyle.paypalRegular11,
              selectedWithdrawType.value == "SWIFT"
                  ? "Withdrawal transaction is processing\nWithdrawal fees: 3%+5\$ \nCredit duration is 2-5 working days"
                  : selectedWithdrawType.value == "SEPA"
                      ? "Withdrawal transaction is processing\nWithdrawal fees: 1.5%+1 EUR\nCredit duration is 1-3 working days"
                      : selectedWithdrawType.value == "SEPA Instant"
                          ? "Withdrawal transaction is processing\nWithdrawal fees: 2%+2 EUR\nCredit duration is immediately"
                          : "Withdrawal transaction is processing\nWithdrawal fees: 3%+1 \$\nCredit duration is 2-5 working days",
            ),
          );
        } else {
          Get.snackbar('Error', response.msg);
        }
      } catch (e) {
        Get.snackbar('Error',
            'Failed to submit bank transfer: ${e.toString() == "type 'Null' is not a subtype of type 'bool'" ? "\n1-Your Card Code Not Found \n 2-check Your balance" : "Please Check Your Data Again"}');
        ("Error: ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    cardCodeController.dispose();
    amountController.dispose();
    accountNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    recAddressCityController.dispose();
    recAddressStreetController.dispose();
    recAddressBuildingController.dispose();
    ibanController.dispose();
    swiftCodeController.dispose();
    routingNumController.dispose();
    bankNameController.dispose();
    bankAddressCityController.dispose();
    bankAddressStreetController.dispose();
    bankAddressBuildingController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';

import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/bank/logic/with_bank_logic.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/bank/logic/with_bank_service.dart';

class BankTransferScreen extends GetView<WithdrawController> {
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WithdrawService());
    WithdrawController controller = Get.put(WithdrawController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 25,
                ),
                appBarWidget(
                    appBarTitle: 'Withdraw Via Bank Transfer',
                    leftPadding: 15.0,
                    style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15)),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormAuth(
                    hinttext: "Card Code",
                    labeltext: "Card Code",
                    mycontroller: controller.cardCodeController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Card Code';
                      }

                      return null;
                    },
                    isNumber: true),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: "Enter Amount. Minimum 50 USD",
                    labeltext: "Amount",
                    mycontroller: controller.amountController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }

                      if ( //double.tryParse(value) == null &&
                          double.tryParse(value)! < 50) {
                        return 'Value must be greater than or equal to 50';
                      }
                      return null;
                    },
                    isNumber: true),

                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: " Enter Your First Name",
                    labeltext: "First Name",
                    mycontroller: controller.firstNameController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  First Name';
                      }
                      return null;
                    },
                    isNumber: false),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: " Enter Your Last Name",
                    labeltext: "Last Name",
                    mycontroller: controller.lastNameController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Last Name';
                      }
                      return null;
                    },
                    isNumber: false),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: "Your Account Number",
                    labeltext: "Account Number",
                    mycontroller: controller.accountNumberController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your account Number';
                      }
                      if (value.length < 5) {
                        return 'The account number must be  more than 4 digits long';
                      }
                      return null;
                    },
                    isNumber: true),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: "Enter Recipient Address City",
                    labeltext: "Recipient Address City",
                    mycontroller: controller.recAddressCityController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Country of Recipient Address';
                      }
                      return null;
                    },
                    isNumber: false),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: "Enter Recipient Address Street",
                    labeltext: "Recipient Address Street",
                    mycontroller: controller.recAddressStreetController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Street of Bank Address';
                      }
                      return null;
                    },
                    isNumber: false),
                const SizedBox(height: 10.0),
                CustomTextFormAuth(
                    hinttext: "Enter Recipient Building Number",
                    labeltext: "Recipient Building Number",
                    mycontroller: controller.recAddressBuildingController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Building Number of Bank ';
                      }
                      return null;
                    },
                    isNumber: true),
                const SizedBox(height: 10.0),
                // Obx(() => Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       child: DropdownButtonFormField<String>(
                //         value: controller.selectedcardCode.value,
                //         focusColor: Colors.white,
                //         dropdownColor: Colors.white,
                //         decoration: InputDecoration(
                //           filled: true,
                //           fillColor: Colors.white,
                //           enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide:
                //                   const BorderSide(color: AppColor.grey)),
                //           focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide:
                //                   const BorderSide(color: AppColor.grey)),
                //           hintStyle: const TextStyle(fontSize: 14),
                //           floatingLabelBehavior: FloatingLabelBehavior.always,
                //           contentPadding: const EdgeInsets.symmetric(
                //               vertical: 5, horizontal: 10),
                //           label: Container(
                //               margin: const EdgeInsets.symmetric(horizontal: 9),
                //               child: Text('Card Code',
                //                   style:
                //                       AppTextStyle.montserratSimiBold14Black)),
                //         ),
                //         items: controller.cardCode
                //             .map((card) => DropdownMenuItem<String>(
                //                   value: card['card_code'],
                //                   child: Text("   ${card['card_code']}",
                //                       style: AppTextStyle
                //                           .montserratSimiBold14Black
                //                           .copyWith(fontSize: 13)),
                //                 ))
                //             .toList(),
                //         onChanged: (value) {
                //           controller.selectedcardCode.value = value;
                //
                //           (
                //               "aaaaaaaaaaaaaa${controller.selectedcardCode.value}");
                //         },
                //       ),
                //     )),
                // const SizedBox(
                //   height: 20,
                // ),
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedCurrency.value,
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: AppColor.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: AppColor.grey)),
                          hintStyle: const TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          label: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(
                                'Currency',
                                style: AppTextStyle.montserratSimiBold14Black
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 13),
                              )),
                        ),
                        items: controller.currencies
                            .map((currency) => DropdownMenuItem<String>(
                                  value: currency['code'],
                                  child: Text("   ${currency['code']}",
                                      style: AppTextStyle
                                          .montserratSimiBold14Black
                                          .copyWith(fontSize: 13)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedCurrency.value = value;

                          ("aaaaaaaaaaaaaa${controller.selectedCurrency.value}");
                        },
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedWithdrawType.value,
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: AppColor.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: AppColor.grey)),
                          hintStyle: const TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          label: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(
                                'Transfer Type',
                                style: AppTextStyle.montserratSimiBold14Black
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 13),
                              )),
                        ),
                        items: controller.withdrawTypes.map((withdrawType) {
                          return DropdownMenuItem<String>(
                            value: withdrawType,
                            child: Text("  $withdrawType",
                                style: AppTextStyle.appBarTextStyle
                                    .copyWith(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedWithdrawType.value = value!;
                        },
                      ),
                    )),
                const SizedBox(height: 20.0),
                Obx(() {
                  if (controller.selectedWithdrawType.value == 'SWIFT' ||
                      controller.selectedWithdrawType.value == 'SEPA Instant' ||
                      controller.selectedWithdrawType.value == 'SEPA') {
                    return Column(
                      children: [
                        // ... [Your or fields for SWIFT, SEPA Instant, SEPA]

                        const SizedBox(height: 10.0),
                        Obx(() => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonFormField<String>(
                                value: controller.selectedCountry.value,
                                focusColor: Colors.white,
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey)),
                                  hintStyle: const TextStyle(fontSize: 9),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  label: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 9),
                                      child: Text(
                                        'Country Of Bank',
                                        style: AppTextStyle
                                            .montserratSimiBold14Black
                                            .copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontSize: 13),
                                      )),
                                ),
                                items: controller.countries
                                    .map((country) => DropdownMenuItem<String>(
                                          value: country['name'],
                                          child: Text(" ${country['name']}",
                                              style: AppTextStyle
                                                  .montserratSimiBold14Black
                                                  .copyWith(fontSize: 12)),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedCountry.value = value;

                                  ("aaaaaaaaaaaaaa${controller.selectedCountry.value}");
                                },
                              ),
                            )),

                        const SizedBox(height: 20.0),
                        CustomTextFormAuthAcceptNumsAndChar(
                          hinttext: " Enter IBAN",
                          labeltext: "IBAN",
                          mycontroller: controller.ibanController,
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter  IBAN';
                            }
                            return null;
                          },
                          isNumber: false,
                        ),
                        const SizedBox(height: 10.0),
                        CustomTextFormAuthAcceptNumsAndChar(
                          hinttext: " Enter SWIFT Code",
                          labeltext: "SWIFT Code",
                          mycontroller: controller.swiftCodeController,
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter  SWIFT Code';
                            }
                            return null;
                          },
                          isNumber: false,
                        ),
                      ],
                    );
                  } else if (controller.selectedWithdrawType.value ==
                      'ACH Routing') {
                    return Column(
                      children: [
                        const SizedBox(height: 20.0),
                        // ... [Your fields for ACH Routing] ...
                        CustomTextFormAuth(
                          hinttext: " Enter Your Routing Number",
                          labeltext: "Routing Number",
                          mycontroller: controller.routingNumController,
                          valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Routing Number';
                            }
                            return null;
                          },
                          isNumber: true,
                        ),
                        const SizedBox(height: 10.0),
                        CustomTextFormAuth(
                            hinttext: "Enter Bank Name",
                            labeltext: "Bank Name",
                            mycontroller: controller.bankNameController,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter  Bank Name';
                              }
                              return null;
                            },
                            isNumber: false),

                        const SizedBox(height: 10.0),
                        CustomTextFormAuth(
                            hinttext: "Bank City Address",
                            labeltext: "Bank City Address",
                            mycontroller: controller.bankAddressCityController,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Address City';
                              }
                              return null;
                            },
                            isNumber: false),
                        CustomTextFormAuth(
                            hinttext: "Bank Street Address",
                            labeltext: "Bank Street Address",
                            mycontroller:
                                controller.bankAddressStreetController,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter  Address';
                              }
                              return null;
                            },
                            isNumber: false),
                        CustomTextFormAuth(
                            hinttext: "Bank Building Number",
                            labeltext: "Bank Building Number",
                            mycontroller:
                                controller.bankAddressBuildingController,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter  Address';
                              }
                              return null;
                            },
                            isNumber: true),
                      ],
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Return an empty container if no matching type
                  }
                }),
                const SizedBox(height: 25.0),
                Obx(() => submitButton(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: AppColor.white,
                              backgroundColor: AppColor.primaryColor)
                          : Text(
                              'Submit',
                              style: AppTextStyle.montserratSimiBold14White,
                            ),
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.submitBankTransfer,
                    )),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/withdraw_button_screen.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
          ),
          appBarWidget(
              appBarTitle: "Deposit",
              style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 23)),
          SizedBox(
            height: 150.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                withdrawWay(
                    containerColor: AppColor.bankTransferColor,
                    nameOFWithdraw: "Bank Transfer",
                    imageWidraw: "assets/images/bank.svg",
                    ontap: () {
                      Get.toNamed(PageName.depositbankTransferScreen);
                    }),
                const Spacer(),
                withdrawWay(
                    containerColor: Colors.grey.withOpacity(0.8),
                    nameOFWithdraw: "Vodafone Cash",
                    imageWidraw: "assets/images/vodafone.svg",
                    ontap: () {
                      Get.toNamed(PageName.vodafoneCashdeposit);
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              children: [
                withdrawWay(
                    containerColor: AppColor.primaryColor,
                    nameOFWithdraw: "USDT",
                    imageWidraw: "assets/images/usdt.svg",
                    ontap: () {
                      Get.toNamed(PageName.usdtDepositScreen);
                    }),
                const Spacer(),
                withdrawWay(
                    containerColor: Colors.black,
                    nameOFWithdraw: "Payment Links",
                    imageWidraw: "assets/images/paylinks.svg",
                    ontap: () {
                      Get.toNamed(PageName.paymentLinkes);
                    }),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

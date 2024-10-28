import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              appBarWidget(
                  appBarTitle: "Withdraw",
                  style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 23)),
              SizedBox(
                height: 150.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    withdrawWay(
                        containerColor: AppColor.bankTransferColor,
                        nameOFWithdraw: "Bank Transfer",
                        imageWidraw: "assets/images/bank.svg",
                        ontap: () {
                          Get.toNamed(PageName.withdrawbankTransferScreen);
                        }),
                    const Spacer(),
                    withdrawWay(
                        containerColor: Colors.grey.withOpacity(0.8),
                        nameOFWithdraw: "Vodafone Cash",
                        imageWidraw: "assets/images/vodafone.svg",
                        ontap: () {
                          Get.toNamed(PageName.vodafoneCashWithdraw);
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              withdrawWay(
                  containerColor: AppColor.primaryColor,
                  nameOFWithdraw: "USDT",
                  imageWidraw: "assets/images/usdt.svg",
                  ontap: () {
                    Get.toNamed(PageName.withdrawUSDTPage);
                  }),
            ],
          ),
        ));
  }
}

Widget withdrawWay(
    {required String nameOFWithdraw,
    required Color containerColor,
    required String imageWidraw,
    required void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 140.h,
      width: 140.w,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nameOFWithdraw,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SvgPicture.asset(
            imageWidraw,
          ),
          // Image(image: AssetImage(imageWidraw))
        ],
      ),
    ),
  );
}

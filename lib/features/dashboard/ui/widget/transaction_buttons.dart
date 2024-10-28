import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionButtons extends StatelessWidget {
  const TransactionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buttonsNameAndPressed(
                buttonTitle: "Deposit",
                onPressed: () {
                  Get.toNamed(PageName.depositScreen);
                }),
            // const SizedBox(
            //   width: 3,
            // ),
            buttonsNameAndPressed(
                buttonTitle: "Withdraw",
                onPressed: () {
                  Get.toNamed(PageName.withdrawScreen);
                }),
            // const SizedBox(
            //   width: 3,
            // ),
            // Use Flexible instead of Expanded
            buttonsNameAndPressed(
                buttonColor: Colors.black87,
                buttonTitle: "ZEUS Transfer",
                onPressed: () {
                  Get.toNamed(PageName.zuesTransfer);
                }),
          ],
        ),
      ),
    );
  }
}

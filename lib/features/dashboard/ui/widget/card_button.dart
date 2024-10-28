import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus/core/constant/app_styles.dart';

class ButtonInDashboardScreen extends StatelessWidget {
  final void Function()? onTap;
  final String buttonName;
  final IconData icon;
  const ButtonInDashboardScreen(
      {super.key, required this.onTap, required this.buttonName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, //() {
      //   Get.toNamed(PageName.cardInfoScreen);
      // },
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400, width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(children: [
          SizedBox(
            width: 10.w,
          ),
            Icon(
            icon,
            size: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(buttonName,
              style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15)),
        ]),
      ),
    );
  }
}

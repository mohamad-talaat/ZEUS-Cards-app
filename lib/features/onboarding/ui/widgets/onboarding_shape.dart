import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/features/onboarding/data/model/onboarding_list.dart';
import 'package:zeus/features/onboarding/logic/onboarding_controller.dart';

class OnBoardingWidgets extends StatelessWidget {
  const OnBoardingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingControllerImp c = Get.put(OnboardingControllerImp());
    return PageView.builder(
        onPageChanged: (index) {
          c.onPageChanged(index);
        },
        controller: c.pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap :true,
        itemCount: onBoardingList.length,
        itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: SvgPicture.asset(
                    onBoardingList[index].image!,
                    fit: BoxFit.contain,
                    width: 190.w,
                    height: 170.h,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    //  textAlign: TextAlign.center,
                    onBoardingList[index].title!,
                    style: AppTextStyle.onBoardingTitle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    // textAlign: TextAlign.center,
                    onBoardingList[index].description!,
                    style: AppTextStyle.onBoardingdescription,
                  ),
                ),
              ],
            ));
  }
}

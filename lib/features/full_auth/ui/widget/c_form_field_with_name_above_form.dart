import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

class CustomTextFormWithNameAboveField extends StatelessWidget {
  final String hinttext;

  final String labeltext;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  Function(dynamic value)? onChanged;
  CustomTextFormWithNameAboveField(
      {super.key,
      this.obscureText,
      this.onTapIcon,
      required this.hinttext,
      required this.labeltext,
      this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber,
      Function(dynamic value)? onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              hinttext,
              style: AppTextStyle.montserratSimiBold14White.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            // width: 200.w,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: isNumber
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                  style: AppTextStyle.montserratSimiBold14Black,
                  validator: valid,
                  controller: mycontroller,
                  obscureText: obscureText == null || obscureText == false
                      ? false
                      : true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColor.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColor.grey)),

                    // hintText: hinttext,
                    // hintStyle: AppTextStyle.montserratSimiBold14Black,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      // child: Text(labeltext,
                      //     style: AppTextStyle
                      //         .montserratSimiBold14BlackForLabelText
//)
                    ),

                    suffixIcon:
                        InkWell(onTap: onTapIcon, child: Icon(iconData)),
                    // border:
                    //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

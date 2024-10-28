import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
import 'package:zeus/features/full_auth/logic/forgetpassword/verifycode_controller.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextbodyauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtexttitleauth.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(VerifyCodeControllerImp());

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.backgroundcolor,
          elevation: 0.0,
          title: Text('Verification Code', style: AppTextStyle.appBarTextStyle),
        ),
        body: GetBuilder<VerifyCodeControllerImp>(
            assignId: true,
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: ListView(children: [
                      const SizedBox(height: 20),
                      const CustomTextTitleAuth(text: "Check code"),
                      const SizedBox(height: 10),
                      const CustomTextBodyAuth(
                          text:
                              "Please Enter The 5-Digit Code Sent To Your Email"),
                      const SizedBox(height: 15),
                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: OtpTextField(
                            enabled: true,
                            autoFocus: true,
                            showFieldAsBox: true,
                            showCursor: false,
                            fieldWidth: 50.0,
                            borderRadius: BorderRadius.circular(20),
                            numberOfFields: 5,
                            borderColor: const Color(0xFF512DA8),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(1),
                            ],
   // Style for fields
          textStyle: const TextStyle(fontSize: 17, color: Colors.black),
                            onCodeChanged: (String code) {},
                            //runs when every textfield is filled
                            onSubmit: (verfiycoderesetpassword) {
                              // if(myServices.sharedPreferences.getString("phone") == "201013280650" ){
                              //   Get.toNamed(PageName.resetPassword);
                              //     //  controller.checkCode("11111");
                              // }else{
 
                              controller.checkCode(verfiycoderesetpassword);}
                           //  }, // end onSubmit
                          )),
                      const SizedBox(height: 40),
                    ]),
                  ),
                )));
  }
}

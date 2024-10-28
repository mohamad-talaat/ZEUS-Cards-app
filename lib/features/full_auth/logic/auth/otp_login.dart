 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
  
const FlutterSecureStorage storage = FlutterSecureStorage();

class OtpVerificationDialog extends StatelessWidget {
  final String otp;
  final VoidCallback onVerified;

  const OtpVerificationDialog(
      {super.key, required this.otp, required this.onVerified});

  @override
  Widget build(BuildContext context) {
    // MyServices myServices = Get.find();
 
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter OTP",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            OtpTextField(
              enabled: true,
              autoFocus: true,
              showFieldAsBox: true,
              showCursor: false,
              numberOfFields: 5,
              fieldWidth: 40,

              onSubmit: (String enteredOtp) async {
                String? token = await storage.read(key: 'auth_token');
                // otp = enteredOtp;
                if (enteredOtp == otp) {
                  onVerified();
                  await storage.write(key: 'auth_token', value: token);

                  
          //  myServices.sharedPreferences.setString("onboarding", "inHome");
             
                } else {
                  Get.snackbar(
                    "Error",
                    "Invalid OTP. Please try again.",
                  );
                }
              },
              // Style for fields
              textStyle: const TextStyle(fontSize: 17, color: Colors.black),
              // Restrict input to single digit
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

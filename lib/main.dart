 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:get/get.dart';
 
import 'core/initial_binding.dart';
import 'core/localization/changelocal.dart';
import 'core/pagescall/pagename.dart';
import 'core/pagescall/routes.dart';
import 'core/services/services.dart';
import 'package:upgrader/upgrader.dart';

 
 
 
void main() async {
  await Future.delayed(const Duration(milliseconds: 450)); //  ثوانٍ
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initialServices();
// await setupFCM();
 // Only call clearSavedSettings() during testing to reset internal values.
 // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  runApp(const MyApp());
}

 
/////////////////////////////////////////
/////////////////////////////////////////////
///////////////////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    
    return ScreenUtilInit(
        // designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return  UpgradeAlert(

        child:GetMaterialApp(
            // home: const BottomNavBar(),
            locale: const Locale('en', 'US'), // Set the locale to English (US)

            // translations: MyTranslation(),
            debugShowCheckedModeBanner: false,
            //  locale: controller.language, //mo@gmail.com
            theme: controller.appTheme,
            initialBinding: InitialBinding(),
            initialRoute: PageName.onBoarding,
            getPages: routes,
          ));
        });
  }
}

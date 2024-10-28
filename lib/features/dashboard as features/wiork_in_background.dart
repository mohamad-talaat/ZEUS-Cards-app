// import 'package:workmanager/workmanager.dart';

 
// // Define a task identifier
// const String taskName = "my_background_task";

// @override
// void initState() {
//   super.initState();
//   // Initialize Workmanager
//   Workmanager().initialize(
//     callbackDispatcher, // Call this method
//     // Configuration options:
//     // - retainRunningTasks: true (to run background tasks even when app is terminated)
//     // - isInDebugMode: false (for production environments)
//   );

//   // Schedule the background task
//   Workmanager().registerPeriodicTask(
//     taskName,
//     taskName,
//     frequency: Duration(minutes: 30), 
//     existingWorkPolicy: ExistingWorkPolicy.replace, // Replace existing task if needed
//   );
// }

// // Callback function for your task
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // Your logout logic here
//     if (task == taskName) {
//       Get.offAllNamed(PageName.login); 
//       myServices.sharedPreferences.setString("onboarding", "inLogin");
//       await myServices.logout();
//       ("Yes This is running >> logout after minute ");
//     }
//     return Future.value(true); 
//   });
// }

// dependencies:
//   workmanager: ^2.0.0


//   أضف ما يلي في AndroidManifest.xml ملف.

// <manifest ...>
//   <application ...>
//     <service
//       android:name="com.transistorsoft.flutter.background.service.WorkmanagerService"
//       android:exported="false" />
//   </application>
// </manifest>
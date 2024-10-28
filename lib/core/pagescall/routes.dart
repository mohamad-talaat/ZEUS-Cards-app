import 'package:zeus/core/middleware/mymiddleware.dart';
import 'package:zeus/core/pagescall/pagename.dart';

import 'package:get/get.dart';
import 'package:zeus/features/Bottom%20Nav%20Bar%20Screens/bottom_nav_bar_screens.dart';
       import 'package:zeus/features/transactions/deposit_entering_data/bank/dep_bank_screen.dart';
 import 'package:zeus/features/transactions/deposit_entering_data/payment%20link/payment_link_screen.dart';
import 'package:zeus/features/transactions/deposit_entering_data/usdt/dep_via_usdt_screen.dart';
import 'package:zeus/features/transactions/deposit_entering_data/vodafone/dep_voda_screen.dart';
import 'package:zeus/features/dashboard/ui/widget/card_code.dart';
import 'package:zeus/features/transactions/deposit_entering_data/deposit_screen.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/withdraw_button_screen.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/with_usdt_screen.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/bank/with_bank_screen.dart';
 import 'package:zeus/features/transactions/withdraw_entering_data/vodafone/vod_with_screen.dart';
 import 'package:zeus/features/full_auth/ui/screen/forgetpassword/forget_pass.dart';
import 'package:zeus/features/full_auth/ui/screen/forgetpassword/resetpassword.dart';
import 'package:zeus/features/full_auth/ui/screen/forgetpassword/success_resetpassword.dart';
import 'package:zeus/features/full_auth/ui/screen/forgetpassword/verifycode.dart';
import 'package:zeus/features/full_auth/ui/screen/login/login.dart';
import 'package:zeus/features/onboarding/ui/onboarding.dart';
import 'package:zeus/features/profile/profile_screen.dart';
import 'package:zeus/features/transactions/zues%20transfer/zues_transfer_screen.dart';

import '../../features/dashboard as features/dashboard/dashboard_screen.dart';

  
List<GetPage<dynamic>> routes = [
  GetPage(
      name: PageName.onBoarding,
      page: () => const OnboardingScreen(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: PageName.login, page: () => const LoginScreen()),
  // GetPage(name: PageName.signUp, page: () => const SignUp()),
  GetPage(name: PageName.forgetPassword, page: () => const ForgetPassword()),
  GetPage(
      name: PageName.resetPassword,
      page: () => const ResetPassword()), //VerfiyCode
  GetPage(
      name: PageName.verfiyCode, page: () => const VerfiyCode()), //VerfiyCode
  GetPage(
      name: PageName.successResetpassword,
      page: () => const SuccessResetPassword()),
  // GetPage(name: PageName.successSignUp, page: () => const SuccessSignUp()),
  // GetPage(
  //     name: PageName.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
 
  GetPage(name: PageName.bottomNavBar, page: () => const BottomNavBar()), 
   GetPage(
    name: PageName.dashboardScreen,
    page: () => const DashboardScreen(),
 
  ),  
  //    GetPage(
  //   name: PageName.transactionsHistoryScreen,
  //   page: () => const TransactionsHistoryScreen(cardId: cardId, pageController: pageController),
 
  // ),  
  GetPage(
      name: PageName.cardInfoScreen,
      page: () => const CardInfoScreen()), 
  GetPage(
      name: PageName.profileScreen,
      page: () => const ProfileScreen()),  
 
  ///////////////////// ///WithdrawScreen  ///////////////////////////////
  GetPage(name: PageName.withdrawScreen, page: () => const WithdrawScreen()),
  GetPage(
      name: PageName.vodafoneCashWithdraw,
      page: () => const VodafoneCashWithDrawScreen()),
  GetPage(
      name: PageName.withdrawUSDTPage, page: () => const WithdrawUSDTPage()),
  GetPage(
      name: PageName.withdrawbankTransferScreen,
      page: () => const BankTransferScreen()),

  ///////////////////// ///deposit Screen  ///////////////////////////////

  GetPage(name: PageName.depositScreen, page: () => const DepositScreen()),
  GetPage(
      name: PageName.vodafoneCashdeposit,
      page: () => const VodafoneCashDepositScreen()),
  GetPage(
      name: PageName.usdtDepositScreen, page: () => const USDTDepositScreen()),
  GetPage(
      name: PageName.depositbankTransferScreen,
      page: () => const DepositBankTransferScreen()),
 
  GetPage(
      name: PageName.paymentLinkes,
      page: () => const PaymentLinkDepositScreen()),

  ///////////////////// ///ZEUS Screen  ///////////////////////////////

  GetPage(
      name: PageName.zuesTransfer,
      page: () => const ZuesTransferScreen()), //ZuesTransfer

 
];

// class PageNamer {
//   Route generateRoute(RouteSettings settings) {
//     //this arguments to be passed in any screen like this ( arguments as ClassName )
//     final arguments = settings.arguments;

//     switch (settings.name) {
//       case Routes.onBoardingScreen:
//         return MaterialPageRoute(
//           builder: (_) => const OnboardingScreen(),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }

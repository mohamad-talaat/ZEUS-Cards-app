import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zeus/core/services/services.dart';

import '../features/dashboard as features/dashboard/dashboard_controller.dart';
import '../features/dashboard as features/transactions/transactions_controller.dart';
import '../features/transactions/deposit_entering_data/bank/logic/dep_bank_data_service.dart';
import '../features/transactions/deposit_entering_data/bank/logic/dep_bank_logic.dart';
import '../features/transactions/deposit_entering_data/payment link/logic/pay_link_data_service.dart';
import '../features/transactions/deposit_entering_data/payment link/logic/paym_link_logic.dart';
import '../features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import '../features/transactions/deposit_entering_data/platform/logic/choose_platform_service_model.dart';
import '../features/transactions/deposit_entering_data/usdt/logic/dep_via_usdt_data_service.dart';
import '../features/transactions/deposit_entering_data/usdt/logic/dep_via_usdt_logic.dart';
import '../features/transactions/deposit_entering_data/vodafone/logic/dep_voda_data_service.dart';
import '../features/transactions/deposit_entering_data/vodafone/logic/dep_voda_logic.dart';
import '../features/transactions/withdraw_entering_data/bank/logic/with_bank_logic.dart';
import '../features/transactions/withdraw_entering_data/bank/logic/with_bank_service.dart';
import '../features/transactions/withdraw_entering_data/usdt/logic/with_usdt_data_service.dart';
import '../features/transactions/withdraw_entering_data/usdt/logic/with_usdt_logic.dart';
import '../features/transactions/withdraw_entering_data/vodafone/logic/vod_with_data_service.dart';
import '../features/transactions/withdraw_entering_data/vodafone/logic/vod_with_logic.dart';
import 'handling with apis & dataView/crud.dart';

class InitialBinding extends Bindings {
  final Crud crud = Crud();

  @override
  void dependencies() {
    // Core dependencies
    Get.put(crud);
    Get.put( MyServices());
    // Get.lazyPut(() => SessionService());
    // Dashboard related
    Get.lazyPut(() => TransactionsController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => PageController());
    // Get.lazyPut(() => ApiService());
    // Deposit related
    Get.lazyPut(() => VodafoneCashDepositService());
    Get.lazyPut(() => VodafoneCashDepositController());
    Get.lazyPut(() => USDTDepositService());
    Get.lazyPut(() => USDTDepositController());
    Get.lazyPut(() => BankDepositController());
    Get.lazyPut(() => BankDepositService());
    Get.lazyPut(() => PaymentLinkDepositController());
    Get.lazyPut(() => PaymentLinkDepositService());
    Get.lazyPut(() => PlatformController());
    Get.lazyPut(() => PlatformService());

    // Withdraw related
    Get.lazyPut(() => WithdrawController());
    Get.lazyPut(() => WithdrawService());
    Get.lazyPut(() => VodafoneCashwithdrawController());
    Get.lazyPut(() => WithdrawVodafoneCashService());
    Get.lazyPut(() => USDTwithdrawController());
    Get.lazyPut(() => WithdrawUSDTService());
  }
}

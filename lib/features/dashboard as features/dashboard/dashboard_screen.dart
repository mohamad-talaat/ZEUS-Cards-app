import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/core/services/services.dart';
import 'package:zeus/features/chat%20support/all.dart';
import 'package:zeus/features/dashboard%20as%20features/dashboard/dashboard_controller.dart';
import 'package:zeus/features/dashboard%20as%20features/transactions/transactions_controller.dart';
import 'package:zeus/features/dashboard%20as%20features/transactions/transactions_history_screen.dart';
import 'package:zeus/features/dashboard/ui/widget/card_button.dart';
import 'package:zeus/features/dashboard/ui/widget/transaction_buttons.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 0.8);
    Get.put(DashboardController());
    final transactionsController = Get.put(TransactionsController());
    // Add this to refresh data when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.refreshAllData();
      if (controller.cardId.value != null) {
        transactionsController
            .loadTransactionsForCard(controller.cardId.value!);
      }
    });
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 5),
          child: RefreshIndicator(
            color: AppColor.primaryColor,
            backgroundColor: AppColor.white,
            onRefresh: () async {
              // await controller.fetchCardData();
              await controller.refreshAllData();
              if (controller.cardId.value != null) {
                await transactionsController
                    .loadTransactionsForCard(controller.cardId.value!);
              }
            },
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.white,
                    backgroundColor: AppColor.primaryColor,
                  ),
                );
              } else if (controller.cards.isEmpty) {
                return const Center(
                  child: Text("No cards available. Please Try again."),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 210,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PageView.builder(
                            controller: pageController,
                            itemCount: controller.cards.length,
                            itemBuilder: (context, index) => _buildCardItem(
                                controller.cards[index],
                                index,
                                controller.cardBalanceTry),
                            onPageChanged: controller.onPageChanged,
                          ),
                          if (controller.cards.length > 1) ...[
                            Positioned(
                              top: 65,
                              left: 10,
                              child: IconButton(
                                onPressed: () {
                                  if (pageController.hasClients &&
                                      pageController.page! > 0) {
                                    pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/previos_arrow.svg',
                                  color: AppColor.primaryColor,
                                  height: 28,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 65,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  if (pageController.hasClients &&
                                      pageController.page! <
                                          controller.cards.length - 1) {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/next_arrow.svg',
                                  color: AppColor.primaryColor,
                                  height: 28,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const TransactionButtons(),
                    const SizedBox(
                      height: 5,
                    ),
                    ButtonInDashboardScreen(
                        buttonName: 'Your ZEUS Cards',
                        onTap: () {
                          Get.toNamed(PageName.cardInfoScreen);
                        },
                        icon: Icons.credit_card),
                    const SizedBox(
                      height: 5,
                    ),
                    ButtonInDashboardScreen(
                        buttonName: 'open ticket to chat support',
                        onTap: () {
                          openNewTicket(myServices.sharedPreferences
                              .getString("userId")!);
                        },
                        icon: Icons.support_agent),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Obx(() => TransactionsHistoryScreen(
                            cardId: controller.cardId.value ?? '',
                            pageController: pageController,
                          )),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(dynamic card, int index, RxString balance) {
    // final cardImage = card['card_image']; //['virtual_card_package']['image'];
    final cardId = card['id'].toString();
    balance = card['money'].toString().obs;

    final fullImageUrl = card['card_image']; //  'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/uploads/$cardImage';

    return GestureDetector(
      onTap: () {
        controller.myServices.sharedPreferences.setString("CardId", cardId);

        Get.toNamed(PageName.cardInfoScreen);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(11), // To account for the border
              child: CachedNetworkImage(
                imageUrl: fullImageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) {             return Container(
                      height: 175,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.primaryColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo12.png',
                            height: 100,
                            width: 80,
                          ),
                          const SizedBox(height: 7),
                          Expanded(
                              child: Text(
                            "No Card Founded , please check your data or the internet",
                            style: AppTextStyle.appBarTextStyle
                                .copyWith(color: AppColor.white, fontSize: 14),
                          ))
                        ],
                      ));},
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Card Balance : ",
                  style:
                      AppTextStyle.montserratBold20.copyWith(fontSize: 14.5)),
              Obx(() => Text(
                    balance.value,
                    style:
                        AppTextStyle.appBarTextStyle.copyWith(fontSize: 13.5),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    controller.backPressCount++;
    if (controller.backPressCount == 4) {
      controller.backPressCount = 0;
    }
    if (controller.backPressCount == 3) {
      return await Get.defaultDialog(
        backgroundColor: Colors.white,
        barrierDismissible: false,
        buttonColor: Colors.grey,
        title: 'Confirm Exit',
        titleStyle: AppTextStyle.appBarTextStyle,
        middleText: 'Are you sure you want to exit?',
        textConfirm: 'YES',
        textCancel: 'No',
        onConfirm: () {
          controller.myServices.logout();
          controller.myServices.sharedPreferences
              .setString("onboarding", "inLogin");
          Get.offAllNamed(
              PageName.login); // Use Get.offAllNamed for complete navigation
        },
        onCancel: () async {
          Get.toNamed(PageName.bottomNavBar);
          controller.backPressCount = 0;
        },
      );
    } else {
      if (controller.backPressCount == 1) {
        Get.snackbar("Exit", "Click again to exit",
            duration: const Duration(seconds: 2));
      }
      return Future.value(false);
    }
  }
}

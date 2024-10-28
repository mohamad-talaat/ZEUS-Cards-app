import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
 import 'package:zeus/core/constant/imgaeasset.dart';

import 'statusrequest.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(fit:BoxFit.fill,
               width: double.infinity, height: double.infinity ,
              'assets/lottie/video.mp4.lottie.json',
            ),
          )
        : statusRequest == StatusRequest.offline
            ? Center(
                child: Lottie.asset(AppImageAsset.offline,
                    width: 250, height: 250))
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: Lottie.asset(AppImageAsset.server,
                        width: 250, height: 250))
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: Lottie.asset(AppImageAsset.noData,
                            width: 250, height: 250, repeat: false))
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(   width: double.infinity, height: double.infinity ,fit: BoxFit.fill,
            
              'assets/lottie/video.mp4.lottie.json',
            ),
          )
        : statusRequest == StatusRequest.offline
            ? Center(
                child: Lottie.asset(AppImageAsset.offline,
                    width: 250, height: 250))
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: Lottie.asset(AppImageAsset.server,
                        width: 250, height: 250))
                : widget;
  }
}

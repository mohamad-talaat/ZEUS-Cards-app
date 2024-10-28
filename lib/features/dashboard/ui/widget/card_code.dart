import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/core/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfoScreen extends StatefulWidget {
  const CardInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardInfoScreenState createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  // Future<List<dynamic>>? cardData;
  final storage = const FlutterSecureStorage();
  MyServices myServices = Get.find();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  List<dynamic>? _cards;

  @override
  void initState() {
    super.initState();
    _fetchCardData(); // Fetch data immediately in initState
    // cardData = _fetchCardData() ;

    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  Future<void> _fetchCardData() async {
    // Use void as return type
    try {
      String? token = await storage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(
            'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/getcards'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data') &&
            responseData['data'] is Map &&
            responseData['data'].containsKey('cards') &&
            responseData['data']['cards'] is List) {
          setState(() {
            _cards = responseData['data']['cards']; // Update _cards
          });
        } else {
          throw Exception('Invalid card data format');
        }
      } else {
        Get.snackbar("Error",
            "Failed to load card data. Please check the internet and try again.",
            duration: const Duration(seconds: 3));
        throw Exception('Failed to load card data');
      }
    } catch (e) {
      //  Get.snackbar("Error", "Failed to load card data. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            appBarWidget(appBarTitle: "Your Cards"),
            Expanded(
              child: _cards == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      backgroundColor: AppColor.primaryColor,
                      color: Colors.white,
                    ))
                  : Container(
                      decoration: const BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Center(
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: _cards!.length,
                                    itemBuilder: (context, index) {
                                      final card = _cards![index];
                                      return _buildCardItem(context, card);
                                    },
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                  ),
                                ),
                                if (_cards!.length > 1)
                                  Positioned(
                                    top: 75,
                                    // top: 0,
                                    // bottom: 0,
                                    left: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        // Check if the current page is not the first page (index 0)
                                        if (_pageController.hasClients &&
                                            _pageController.page! > 0) {
                                          _pageController.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                if (_cards!.length > 1)
                                  Positioned(
                                    top: 75,
                                    // top: 0,
                                    // bottom: 0,
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        // Check if the current page is not the last page
                                        if (_pageController.hasClients &&
                                            _pageController.page! <
                                                _cards!.length - 1) {
                                          _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
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
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                top: 10.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 20.h,
                              ),
                              child: SingleChildScrollView(
                                child: _buildCardDetails(_cards![_currentPage]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, dynamic card) {
    // final cardImage = card['virtual_card_package']['image'];
    // final fullImageUrl =
    //     'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/uploads/$cardImage';
    final fullImageUrl = card['card_image'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.grey[300]!, width: 5),//Colors.grey[300]!
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // To account for the border
              child: CachedNetworkImage(
                imageUrl: fullImageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
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
                      ));
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '',
              style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 13.5),
            ),
            Text(" ",
                style: AppTextStyle.montserratBold20.copyWith(fontSize: 14.5)),
          ],
        )
      ],
    );
  }

  Widget _buildCardDetails(dynamic card) {
    // Define premium features
    final List<String> premiumFeatures = [
      "The card can be linked to your PayPal account.",
      "Withdrawals via: Vodafone Cash, USDT, and bank transfer.",
      "Deposits via: Vodafone Cash, USDT, bank transfer, and payment links."
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text('Card Details', style: AppTextStyle.appBarTextStyle),
        ),
        const SizedBox(height: 20),
        _buildCardDetailRow('Card Holder', card['card_holder_name'].toString()),
        const SizedBox(height: 14),

        ( card['virtual_card_package_id'] == null || card["card_image"]== "https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/images/cards/mastercard/Physical Card.png")
            ? _buildCardDetailRow('Card Name', "physical Card")
            : _buildCardDetailRow(
                'Card Name', card["virtual_card_package"]['name'].toString()),
        // _buildCardDetailRow(
        //     'Card Name', card["virtual_card_package"]['name'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('ZEUS Card Code', card['card_code']),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'ZEUS Expiry Date : ',
                style: AppTextStyle.montserratSimiBold14Black.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryColor),
              ),
              TextSpan(
                  text: _formatExpiryDate(card['valid_until'].toString()),
                  style: const TextStyle(
                    fontFamily: "assets/fonts/Montserrat-SemiBold.ttf",
                    color: Colors.black,
                    fontSize: 14,
                  ))
            ])),
          ],
        ),
        const SizedBox(height: 14),
        _buildCardDetailRow('Card Balance', card['money'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('Type', card['type'].toString()),

        const SizedBox(height: 14),
        _buildCardDetailRow('Card Number', card['card_num'].toString()),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Expiry Date : ',
                style: AppTextStyle.montserratSimiBold14Black.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryColor),
              ),
              TextSpan(
                  text: _formatExpiryDate(card['expiry'].toString()),
                  style: const TextStyle(
                    fontFamily: "assets/fonts/Montserrat-SemiBold.ttf",
                    color: Colors.black,
                    fontSize: 14,
                  ))
            ])),
          ],
        ),
        const SizedBox(height: 14),
        _buildCardDetailRow('CVV ', card['cvv'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('Beneficiary ', card['beneficiary'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('IBAN ', card['IBAN'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('BIC ', card['BIC'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('Intermediary BIC ', card['int_BIC'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow('Beneficiary Address ', card['address'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow(
            'Bank/Payment Institution ', card['inst'].toString()),
        const SizedBox(height: 14),
        _buildCardDetailRow(
            'Bank/Payment Institution Address', card['address'].toString()),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Features : ',
                    style: AppTextStyle.montserratSimiBold14Black.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primaryColor),
                  ),
                  // Check if it's a physical card or if virtual_card_package has features
                  ...(card['card_type'] == "physical"
                      ? premiumFeatures.map((feature) => TextSpan(
                            text: '${_formatFeature(feature)}\n',
                            style: const TextStyle(
                              fontFamily:
                                  "assets/fonts/Montserrat-SemiBold.ttf",
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ))
                      : (card['virtual_card_package']?['features'] ?? [])
                          .map((feature) => TextSpan(
                                text: '${_formatFeature(feature.toString())}\n',
                                style: const TextStyle(
                                  fontFamily:
                                      "assets/fonts/Montserrat-SemiBold.ttf",
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ))),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  String _formatFeature(String feature) {
    final keywords = [
      'Withdrawals via',
      'Deposits via',
      'Withdraw via',
      'Deposit via'
    ];
    for (var keyword in keywords) {
      if (feature.contains(keyword)) {
        return feature.replaceAll(
          keyword,
          '[$keyword]\n ',
        );
      }
    }
    return feature;
  }

  String _formatExpiryDate(String expiryDate) {
    // Split the expiry date
    List<String> parts = expiryDate.split('-');
    // Rearrange the parts
    return '${parts[2]} - ${parts[1]} - ${parts[0]}';
  }
}

Widget _buildCardDetailRow(String label, String? value) {
  return Column(
    children: [
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: '$label : ',
          style: AppTextStyle.montserratSimiBold14Black.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryColor),
        ),
        TextSpan(
            text: value ?? '',
            style: const TextStyle(
              fontFamily: "assets/fonts/Montserrat-SemiBold.ttf",
              color: Colors.black,
              //   fontWeight: FontWeight.w400,
              fontSize: 14,
            ))
      ])),
    ],
  );
}

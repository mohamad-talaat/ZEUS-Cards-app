import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/services/services.dart';
import 'package:zeus/features/chat%20support/all.dart';

import '../../core/constant/color.dart';
import 'package:upgrader/upgrader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  // final SessionService sessionService = Get.find();
  MyServices myServices = Get.find();
  // @override
  // void initState() {
  //   super.initState();
  //   sessionService.validateSession();
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getFromSharedPref({required String name}) {
      return myServices.sharedPreferences.getString(name).toString();
    }

    return UpgradeAlert(
        upgrader: Upgrader(  debugDisplayAlways: true,
        durationUntilAlertAgain: const Duration(days: 1),
    ),
    child:Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Profile",
            style: AppTextStyle.appBarTextStyle,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/login.png"),
              fit: BoxFit.cover,
            )),
            child: SingleChildScrollView(
              controller: _scrollController, // Assign scroll controller
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Adjust for app bar height
                  Center(child: _buildProfileAvatar()),
                  const SizedBox(height: 20),

                  //   IconButton(onPressed: (){
                  //     Get.to(OpenTicketScreen());
                  //   }, icon:const Icon(Icons.chat_bubble)

                  //  ),
                  InkWell(
                    onTap: () {
                      // Get.to(  OpenTicketsList(userId: getFromSharedPref(name: "userId").toString()));
                      openNewTicket(getFromSharedPref(name: "userId"));

                      // Get.to(    const SupportChat());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.support_agent,
                            color: AppColor.primaryColor,
                            size: 33,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "open ticket to chat support",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // _buildProfileInfo(
                  //   'Your ID',
                  //   getFromSharedPref(name: "userId"),
                  //   Icons.wb_iridescent_sharp,
                  // ),
                  _buildProfileInfo(
                    'account number',
                    getFromSharedPref(name: "account_number"),
                    Icons.account_balance,
                  ),
                  _buildProfileInfo(
                    'Name',
                    // getFromSharedPref(name: "name"),
                    getFromSharedPref(name: 'name'),
                    Icons.person,
                  ),

                  _buildProfileInfo(
                    'Email',
                    getFromSharedPref(name: "email"),
                    Icons.email,
                  ),
                  _buildProfileInfo(
                    'Birth Date',
                    getFromSharedPref(name: "birthdate"),
                    Icons.date_range_outlined,
                  ),
                  _buildProfileInfo(
                    'Phone Number',
                    getFromSharedPref(name: "phone"),
                    Icons.phone,
                  ),
                  _buildProfileInfo(
                    'National ID',
                    getFromSharedPref(name: "national_id"),
                    Icons.inbox_rounded,
                  ),
                  _buildProfileInfo(
                    'Passport',
                    getFromSharedPref(name: "passport"),
                    Icons.pause_presentation_sharp,
                  ),

                  _buildProfileInfo(
                    'Address',
                    getFromSharedPref(name: "address"),
                    Icons.location_city,
                  ),
                  // Add more fields as needed (address, ID, etc.)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20, // Position from the bottom
            right: 20, // Position from the right
            child: InkWell(
              onTap: () {
                // Scroll to the bottom of the page
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Make it circular
                  color: Colors.white, // White background
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_downward_sharp,
                    size: 30,
                    color: AppColor.primaryColor, // Blue arrow color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
     ) );
  }

  Widget _buildProfileAvatar() {
    // Placeholder for now; replace with user image fetching logic
    return const CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white,
      child: Icon(Icons.person, size: 90, color: AppColor.primaryColor),
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColor.primaryColor,
            size: 33,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  value, // Handle null values
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
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

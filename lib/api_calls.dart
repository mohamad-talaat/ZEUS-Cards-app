class APILink {
  // String  LinkServerName = "http://10.0.2.2/noteapp"; // 10.0.2.2 is localhost for emulator
  // static const String linkServerName = "http://10.0.2.2/qubitart"; //10.0.2.2
  static const String linkServerName =
      "https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api"; //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api
//https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/login
////////////////////////////////////// Auth  //////////////////////////////////////////
  static const String linkVerfiyCodeSignUp =
      "$linkServerName/auth/verfiycode.php";

  static const String linkForResendVerfiyCode =
      "$linkServerName/auth/resend.php";
  static const String linkLogin = "$linkServerName/user/login";
  ////////////////////////////////////// forget password  //////////////////////////////////////////
  static const linkFetchCard =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/getcards';
  //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/sendOTP?phone=201013280650
  static const String linkToSendOTP = "$linkServerName/user/SendOTP";
  //
  //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/checkOTP?phone=201013280650&otp=32804
  static const String linkverfiycodeforgetpassword =
      "$linkServerName/user/checkOTP";

  //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/forgotPassword?phone=201013280650
  static const String linkResetPassword = "$linkServerName/user/forgotPassword";
  ////////////////////////////////////// Auth  //////////////////////////////////////////

  static const String linkSignUp = "$linkServerName/auth/signup.php";
}

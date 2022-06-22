import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as parser;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikolo/UI/VideoPlayerScreen.dart';
import 'package:wikolo/UI/WikoloBoard.dart';
import 'package:wikolo/UI/uploadpost.dart';

// // ******BUILD********//
// const appTenant = String.fromEnvironment('TENANT', defaultValue: 'prod');

// // ******Paths********//
// var webPath = "https://stormboard.com";
var baseUrl = "https://api.wikolo.com";

// // ******Default Stormboard Colors********//
const colorLocalTheme = Color(0xFFFFF2ED);
const colorLocalGrey = Color(0xFF6D6E70);
const colorLocalLightBlue = Color(0xFF68C0E3);
const colorLocalDarkBlue = Color(0xFF3789A4);
const colorLocalDarkestBlue = Color(0xFF0B325C);
const colorLocalLightGrey = Color(0xFF8D8F91);
const colorLocalVeryLightGrey = Color(0xFFB3B3B3);
const colorLocalDarkGrey = Color(0xFF9D9D9D);
const colorLocalBackgroundLightGrey = Color(0xFFF2F2F2);
const colorLocalCyan = Color(0xFF35F0F1);
const colorLocalRoyalBlue = Color(0xFF358DF1);
const colorLocalCobaltBlue = Color(0xFF3357E7);
const colorLocalGreen = Color(0xFF33E7B5);
const colorLocalRed = Color(0xFFEB7C63);
const colorLocalOrange = Color(0xFFF39C12);
const colorLocalLightRed = Color(0xFFFFE7E1);
const colorLocalPink = Color(0xFFEA3C75);
const placeholderColor = colorLocalGrey;

// // ******Color Code********//
const appBackgroundColor = Color(0xFFFFFFFF);
const appThemeColor1 = colorLocalTheme;
// final appThemeColor1Light = Color(0xFFE0F6FF);
// final buttonBorderColor = colorStormboardVeryLightGrey;
const labelColor = colorLocalGrey;
// final placeholderColor = colorStormboardGrey;
// final colorCancelButton = colorStormboardRed;
// final colorStormboardShadow = Color(0xFFD6D6D6);
// final colorStormboardTile = Color(0xFF9D9D9D);
// final colorStormboardTileSelected = Color(0xFF0B325C);
// final colorStormboardTileDropShadow = Color(0xFFAAAAAA);
// final colorStormboardMyVotes = Color(0xFF747474);
// final colorStormboardStarFill = Color(0xFFEFF351);
// final colorStormboardOnline = Color(0xFF00D181);

// final String helpLink = "https://help.stormboard.com/mobile-and-tablet-apps";
// final String privacyPolicyLink = "https://stormboard.com/legal/privacy-policy";
// final String termsLink = "https://stormboard.com/legal/terms-of-service";
// final String linkedinRedirectUrl = 'https://stormboard.com/auth/index';
// final String linkedinClientId = '78qm7wcygn43gk';
// final String linkedinClientSecret = 'e79PpdY9wtvwVdmB';

// // ****** Google ********//
// const String GOOGLE_API_KEY = 'AIzaSyCy7X-4J9QGg4J05THqY_0wlR50bWqbxpA';

// ****** Fonts ********//
const globalFont = "Quicksand";

double globalFontSize = 22.0;
var globalFontWeight = FontWeight.w800;

// Constants
const methodLogin = "login";
const methodSignup = "signup";
const methodGetMessagesList = "getMessages";
const methodPushMessage = "pushMessage";

const kDataLoginUser = "loginuser";
const kDataData = "data";
const kDataID = "id";
const kDataName = "name";
const kDataMobileNo = "mobileno";
const kDataCreatedDate = "createddate";
const kDataCreated = "created";
const kDataLastLoginDate = "lastlogindate";
const kDataCode = "code";
const kDataError = "error";
const kDataErrors = "errors";
const kDataSuccess = "success";
const kDataAPS = "aps";
const kDataMessage = "message";
const kDataMessages = "messages";
const kDataNotification = "notification";
const kDataNotifications = "notifications";
const kDataPayload = "payload";
const kDataBody = "body";
const kDataAlert = "alert";
const kDataSender = "sender";
const kDatacreatedDate = "createdDate";
const kDataTime = "time";
const kDataDate = "date";
const kDataDeviceToken = "devicetoken";
const kDataUser = "user";
const kDataUsers = "Users";
const kDatausers = "users";
const kDataToken = "token";
const kDataDashboard = "dashboard";
const kDataPhone = "phone";
const kDataPhoneNumber = "phone_number";
const kDataCountry = "country";
const kDataEmail = "email";
const kDataPassword = "password";
const kDataFirstname = "firstname";
const kDataLastname = "lastname";
const kDataStartDate = "start_date";
const kDataDueDate = "due_date";
const kDataDescription = "description";
const kDataMonth = "month";
const kDataYear = "year";
const kDataCountries = "countries";
const kDataTitle = "title";
const kDataFullName = "fullname";
const kDataStates = "states";
const kDataCities = "cities";
const kDataAddress = "address";
const kDataMobile = "mobile";
const kDataAvatar = "avatar";
const kDataOtpCode = "otpCode";
const kDataStatus = "status";
const kDataStatusCode = "status_code";
const kDataOtp = "otp";
const kDataIsAdmin = "is_admin";
const kDataRemembered = "remembered";
const kDataHex = "hex";
const kDataKey = "key";
const kDataLat = "lat";
const kDataLon = "lon";
const kDataResult = "result";
const kDataImageUrl = "image_url";
const kDataWbi = "wbi";
const kDataUserProfile = "userprofile";
const kDataUsername = "username";
const kDataUserImg = "userimg";
const kDataWikImages = "wikimages";
const kDataCategory = "category";
const kDataWikfile = "wikfile";
const kDataImages = "images";
const kDataVideos = "videos";
const kDataLive = "live";
const kDataLocation = "location";
const kDataStreamType = "streamtype";
const kDataPrice = "price";
const kDataLiveStreamJoin = "livestreamjoin";
const kDataPricePerUser = "priceperuser";
const kDataComment = "comment";
const kDataReply = "reply";
const kDataCount = "count";
const kDataImageId = "imageid";

// ************************************Navigation Samples************************
// Source: https://pub.dev/packages/page_transition

// Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(second: 1), child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: DetailScreen()));

// Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DetailScreen()));

// */

SetHomePage(int index, String screenName) async {
  Widget screen;

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          tabBarTheme: const TabBarTheme(
              labelColor: appThemeColor1, unselectedLabelColor: Colors.grey),
          fontFamily: globalFont,
          buttonTheme: ButtonThemeData(
              buttonColor: appThemeColor1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textTheme: ButtonTextTheme.accent,
              height: 50),
          primaryTextTheme: TextTheme(
            bodyText1: const TextStyle(fontSize: 18.0),
            bodyText2: const TextStyle(fontSize: 18.0),
            headline1: const TextStyle(fontSize: 18.0),
            headline2: const TextStyle(fontSize: 18.0),
            headline3: const TextStyle(fontSize: 18.0),
            headline4: const TextStyle(fontSize: 18.0),
            headline5: const TextStyle(fontSize: 18.0),
            headline6: TextStyle(
              fontSize: globalFontSize,
              fontWeight: globalFontWeight,
              color: labelColor,
              fontFamily: globalFont,
            ),
            subtitle1: const TextStyle(fontSize: 25.0),
            subtitle2: const TextStyle(fontSize: 25.0),
            caption: const TextStyle(fontSize: 18.0),
            button: const TextStyle(fontSize: 18.0),
            overline: const TextStyle(fontSize: 18.0),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: false,
            titleSpacing: 0,
            color: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            titleTextStyle: TextStyle(
              fontSize: globalFontSize,
              fontWeight: globalFontWeight,
              color: labelColor,
              fontFamily: globalFont,
            ),
          )),
      home: SocialBoard()));
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

/*
====================================================================================

Spin kit Source : https://flutterappdev.com/2019/01/29/a-collection-of-loading-indicators-animated-with-flutter/

====================================================================================
*/

void ShowLoader(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Container(
          height: 50,
          child: const AbsorbPointer(
            absorbing: true,
            // child: Image.asset("images/loader.gif"),
            child: SpinKitRing(
              color: Color(0xFFE0F6FF),
              lineWidth: 5,
            ),
          ),
        );
      }));
}

void HideLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void ShowErrorMessage(String message, BuildContext context) {
  showSnackBar(message, context, colorLocalRed, false);
}

void ShowInfoMessage(String message, BuildContext context) {
  showSnackBar(message, context, colorLocalCobaltBlue, true);
}

void ShowSuccessMessage(String message, BuildContext context) {
  showSnackBar(message, context, colorLocalGreen, false);
}

void ShowWarningMessage(String message, BuildContext context) {
  showSnackBar(message, context, colorLocalOrange, true);
}

void showToastMessage(String type, String message, BuildContext context) {
  switch (type) {
    case "error":
      ShowErrorMessage(message, context);
      break;
    case "success":
      ShowSuccessMessage(message, context);
      break;
    case "warning":
      ShowSuccessMessage(message, context);
      break;
    case "info":
    default:
      ShowInfoMessage(message, context);
      break;
  }
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showSnackBar(
    String message, BuildContext context, Color bgColor, bool isToast) {
  final document = parser.parse(message);
  final String parseMessage =
      parser.parse(document.body?.text).documentElement!.text;

  SchedulerBinding.instance.addPostFrameCallback(
      (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: isToast
                ? EdgeInsets.fromLTRB(16, 5, 16, 80)
                : EdgeInsets.fromLTRB(16, 5, 16, 50),
            duration: Duration(seconds: 2),
            content: Text(
              parseMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: bgColor,
          )));
}

Future<bool> sharedPreferenceContainsKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool result = prefs.containsKey(key);
  return result;
}

void SetSharedPreference(String key, dynamic value) async {
  var str = convert.json.encode(value);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString(key, str);
}

dynamic GetSharedPreference(String key) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (prefs.getString(key) != null) {
  //   dynamic obj = convert.jsonDecode(prefs.getString(key));
  //   return obj;
  // }
}

void RemoveSharedPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

BoxDecoration SetBackgroundImage(String image) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(image),
      fit: BoxFit.cover,
    ),
  );
}

BoxDecoration setBoxDecoration(Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: appThemeColor1.withAlpha(50), width: 1),
    color: color,
  );
}

BoxDecoration setBoxDecorationForUpperCorners(Color color, Color shadowColor) {
  return BoxDecoration(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      color: color,
      boxShadow: []);
}

setNavigationTransition(Widget targetWidget) {
  return PageTransition(
      duration: const Duration(milliseconds: 300),
      type: PageTransitionType.rightToLeft,
      child: targetWidget,
      alignment: Alignment.centerLeft);
}

InputDecoration setInputDecoration(
    String labelText,
    String hintText,
    Color fillColor,
    Color labelTextColor,
    Color borderColor,
    FocusNode myFocusNode) {
  return InputDecoration(
    labelStyle: TextStyle(
      color: myFocusNode.hasFocus ? colorLocalOrange : placeholderColor,
    ),
    hintStyle: const TextStyle(
      color: placeholderColor,
    ),
    errorStyle: const TextStyle(color: Colors.red),
    labelText: labelText,
    hintText: hintText,
    focusColor: myFocusNode.hasFocus ? colorLocalOrange : Colors.black,
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalOrange, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalOrange, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorLocalVeryLightGrey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        )),
  );
}

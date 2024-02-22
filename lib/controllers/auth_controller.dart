import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../constants/page_navigation.dart';
import '../models/user_model.dart';
import '../preferences/auth_prefrence.dart';
import '../utilities/widgets/custom_dialog.dart';
import '../views/auth/login_page.dart';
import '../views/auth/otp_screen.dart';
import '../views/auth/post_login/enable_notification.dart';
import '../views/home/bottom_nav_bar.dart';
import 'base_controller.dart';

class AuthController extends GetxController {
  final AuthPrefrence _authPreference = AuthPrefrence.instance;
  final BaseController _baseController = BaseController.instance;
  RxString accessToken = "".obs;
  RxBool savId = true.obs;
  RxBool isLoggedIn = false.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<String> userId = ''.obs;

  @override
  Future<void> onInit() async {
    accessToken.value = await _authPreference.getUserDataToken();
    isLoggedIn.value = await _authPreference.getUserLoggedIn();
    var res = await _authPreference.getUserData();
    if (isLoggedIn.value) {
      var result = json.decode(res);
      userData.value = UserModel.fromJson(result['Data']);
    } else {}

    update();
    super.onInit();
  }

  /*<---------------------Signup--------------------->*/

  Future verifyOtp(var body, signUpBody) async {
    _baseController.showLoading('Verifying OTP...');

    var response = await DataApiService.instance.post('auth/verify/otp', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });

    if (response == null) {
      _baseController.hideLoading();
      return;
    }

    var result = json.decode(response);
    print(result);
    _baseController.hideLoading();

    if (!result['Error']) {
      Go.to(() => OTPScreen(
            email: body['email'].toString(),
            otpCode: result['otp'].toString(),
            body: signUpBody,
            signUp: true,
          ));
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  Future signUp(var body) async {
    _baseController.showLoading('Logging user...');
    var response = await DataApiService.instance.post('auth/signup', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      var log = {
        'email': body['email'],
        'password': body['password'],
      };
      userLogin(log);
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  /*<---------------------Login--------------------->*/

  Future userLogin(var body) async {
    String token = (await FirebaseMessaging.instance.getToken())!;

    // Add the token field to the body
    body['fcm_token'] = token;
    _baseController.showLoading('Logging user...');
    var response = await DataApiService.instance.post('auth/login', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      userData.value = UserModel.fromJson(result['Data']);
      accessToken.value = result['token'];
      _authPreference.saveUserData(token: response);
      _authPreference.saveUserDataToken(token: accessToken.value);
      _authPreference.setUserLoggedIn(true);

      update();
      await Permission.notification.isDenied.then((value) {
        if (value) {
          Go.offUntil(() => const EnableNotificationScreen());
          Permission.notification.request();
        } else {
          Go.offUntil(() => const BottomNavBar());
        }
      });
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  /*<---------------------Logout--------------------->*/

  Future signOut() async {
    _baseController.showLoading('Signing out...');
    _authPreference.saveUserDataToken(token: '');
    _authPreference.setUserLoggedIn(false);
    _authPreference.saveUserData(token: '');
    isLoggedIn(false);
    accessToken.value = '';
    update();
    _baseController.hideLoading();
    Go.offUntil(() => const LoginScreen());
  }

  Future forgotPassword(var body) async {
    _baseController.showLoading('Sending otp to you email...');
    var response = await DataApiService.instance.post('auth/forgot/password', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      Go.to(() => OTPScreen(otpCode: result['otp'].toString(), email: body['email']));
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
      return result["Message"];
    }
  }

  Future resetPassword(var body) async {
    _baseController.showLoading('Updating your password...');
    var response = await DataApiService.instance.post('auth/reset/password', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;

    _baseController.hideLoading();
    var result = json.decode(response);
    print(result);
    if (!result['Error']) {
      Go.offUntil(() => const LoginScreen());
    } else {
      CustomDialogBox.showErrorDialog(description: result["Message"]);
    }
  }

  Future<void> editProfile(String userId, String name, String? imagePath) async {
    _baseController.showLoading('Updating your profile...');

    final String token = accessToken.value;

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://eramsaeed.com/Durood-App/api/auth/edit/profile'),
    );

    request.fields.addAll({
      'user_id': userId,
      'name': name,
    });

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> result = json.decode(responseBody);

      if (result["Error"] == false) {
        _baseController.hideLoading();
        userData.value = UserModel.fromJson(result["User"]);

        CustomDialogBox.showSuccessDialog(
            description: result["Message"],
            onPressed: () {
              Go.offUntil(() => const BottomNavBar());
            });
      } else {
        _baseController.hideLoading();

        CustomDialogBox.showErrorDialog(description: result["Message"]);
      }
    } catch (error) {
      _baseController.hideLoading();

      CustomDialogBox.showErrorDialog(description: 'Error updating profile');
      print('Error during edit profile request: $error');
    }
  }
}

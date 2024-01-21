import 'dart:convert';

import 'package:get/get.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../constants/page_navigation.dart';
import '../models/user_model.dart';
import '../preferences/auth_prefrence.dart';
import '../utilities/widgets/custom_dialog.dart';

import 'base_controller.dart';

class AuthController extends GetxController {
  final AuthPrefrence _authPrefrence = AuthPrefrence.instance;
  final BaseController _baseController = BaseController.instance;
  RxString accessToken = "".obs;
  RxString userRefreshToken = "".obs;

  RxBool savId = true.obs;

  RxBool isLoggedIn = false.obs;

  Rx<UserModel> userData = UserModel(userId: 1).obs;

  Rx<String> userId = ''.obs;

  @override
  Future<void> onInit() async {
    accessToken.value = await _authPrefrence.getUserDataToken();
    userRefreshToken.value = await _authPrefrence.getUserRefreshToken();
    isLoggedIn.value = await _authPrefrence.getUserLoggedIn();
    if (isLoggedIn.value) {
      refreshToken();
    } else {
      // refreshToken();
    }

    update();
    super.onInit();
  }

  /*<---------------------Login--------------------->*/

  Future userLogin(var body) async {
    _baseController.showLoading('Logging user...');
    var response =
        await DataApiService.instance.post('/login', body).catchError((error) {
      if (error is BadRequestException) {
        return error.message!;
      } else {
        _baseController.handleError(error);
      }
    });

    if (response == null) return;
    _baseController.hideLoading();
    var result = json.decode(response);
    if (result['status'] == "success") {
      userData.value = UserModel.fromJson(result['user']);
      accessToken.value = userData.value.accessToken!;
      userRefreshToken.value = userData.value.refreshToken!;
      update();
      // Go.offUntil(() => const BottomBar());
      return '';
    } else {
      return result["errorMsg"];
    }
  }

  /*<---------------------Logout--------------------->*/

  Future signOut() async {
    _baseController.showLoading('Signing out...');
    _authPrefrence.saveUserDataToken(token: '');
    _authPrefrence.setUserLoggedIn(false);
    _authPrefrence.saveUserData(token: '');
    isLoggedIn(false);
    accessToken.value = '';
    update();
    _baseController.hideLoading();
    // Get.offAll(() => const LoginScreen());
  }

  Future refreshToken() async {
    var body = {'token': userRefreshToken.value};
    var response = await DataApiService.instance
        .post('/refresh_token', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialogBox.showErrorDialog(description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    if (response == null) return;
    var result = json.decode(response);

    userData.value = UserModel.fromJson(result);
    accessToken.value = userData.value.accessToken!;
    userRefreshToken.value = userData.value.refreshToken!;
    if (savId.isTrue) {
      _authPrefrence.saveUserDataToken(token: accessToken.value);
      _authPrefrence.saveUserRefreshToken(token: userRefreshToken.value);
      _authPrefrence.setUserLoggedIn(true);
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
    update();
  }
}

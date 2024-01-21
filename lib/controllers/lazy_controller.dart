import 'package:get/get.dart';

import 'auth_controller.dart';

// LazyController class is a subclass of Bindings class from the Get package.
class LazyController extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(AuthController());
  }
}

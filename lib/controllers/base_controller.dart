import '../api_services/api_exceptions.dart';
import '../utilities/widgets/custom_dialog.dart';

class BaseController {
  BaseController._();

  static final BaseController _instance = BaseController._();
  static BaseController get instance => _instance;
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      CustomDialogBox.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      CustomDialogBox.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      CustomDialogBox.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    }
  }

  showLoading([String? message]) {
    CustomDialogBox.showLoading(message);
  }

  hideLoading() {
    CustomDialogBox.hideLoading();
  }
}

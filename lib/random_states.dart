import 'package:flutter/cupertino.dart';

class RandomStates extends ChangeNotifier {
  String categoryName;
  String logError = '';

  bool isOffer = false;
  bool loading = false;

  int radioValue;

  void getCategoryName(String newName) {
    categoryName = newName;
    notifyListeners();
  }

  void offerChose(bool value) {
    isOffer = value;
    notifyListeners();
  }

  void getRadioValue(int i) {
    radioValue = i;
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  void updateLogErrorMassage() {
    logError = 'ايميل غير صحيح';
    notifyListeners();
  }
}

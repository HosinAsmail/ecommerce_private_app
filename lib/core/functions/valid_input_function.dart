import 'package:ecommerce_private_app/core/extension/number_extensions.dart';
import 'package:get/get.dart';

validInput(String value, int min, int max, String type) {
  if (value.isEmpty) {
    return 'the field is required';
  }

  if (type == 'username') {
    if (!GetUtils.isUsername(value)) {
      return 'not valid username';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(value)) {
      return 'not valid email';
    }
  }
  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(value)) {
      return 'not valid phone number';
    }
  }
  if (type == "discount") {
    if (value.toInt() > 100) {
      return "can not be more than 100%";
    } else if (value.contains("%")) {
      return "please remove the percent sign ";
    }
  }
  if (value.length < min) {
    return "value can't be less thant $min";
  }

  if (value.length > max) {
    return "value can't be bigger thant $max";
  }
}

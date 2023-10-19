import 'package:ecommerce_private_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

Future<int?> showColorPicker(context) {
  int? numberColor;
  return showDialog(
    builder: (context) => AlertDialog(
      title: const Text('اختر لوناً'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: Colors.red,
          onColorChanged: (color) {
            numberColor = color.value;
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(S.current.onboarding_done),
          onPressed: () {
            Get.back(result: numberColor);
          },
        ),
      ],
    ),
    context: context,
  );
}

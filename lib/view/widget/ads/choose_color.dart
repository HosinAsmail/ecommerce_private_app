import 'package:ecommerce_private_app/core/extension/number_extensions.dart';
import 'package:ecommerce_private_app/core/functions/show_color_picker.dart';
import 'package:flutter/material.dart';

class ChooseColor extends StatefulWidget {
  const ChooseColor({
    super.key,
    required this.text,
    required this.mainColorControl,
  });
  final String text;
  final TextEditingController mainColorControl;

  @override
  State<ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor> {
  int mainColor = Colors.grey.value;
  @override
  Widget build(BuildContext context) {
    if (widget.mainColorControl.text.contains("color")) {
      mainColor = widget.mainColorControl.text.substring(0, 10).toInt();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              int? colorNumber = await showColorPicker(context);
              if (colorNumber != null) {
                setState(() {
                  mainColor = colorNumber;
                  widget.mainColorControl.text = colorNumber.toString();
                });
              }
            },
            child: Text(widget.text)),
        GestureDetector(
          onTap: () async {
            int? colorNumber = await showColorPicker(context);
            if (colorNumber != null) {
              setState(() {
                mainColor = colorNumber;
                widget.mainColorControl.text = colorNumber.toString();
              });
            }
          },
          child: Container(
            width: 20,
            height: 20,
            color: Color(mainColor),
          ),
        )
      ],
    );
  }
}

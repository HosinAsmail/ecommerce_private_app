import 'package:ecommerce_private_app/core/extension/number_extensions.dart';
import 'package:flutter/material.dart';

class DropDownStateButton extends StatefulWidget {
  const DropDownStateButton({super.key, required this.stateControl});
  final TextEditingController stateControl;
  @override
  State<DropDownStateButton> createState() => _DropDownStateButtonState();
}

class _DropDownStateButtonState extends State<DropDownStateButton> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.stateControl.text == "1 previous data" ||
        widget.stateControl.text == "0 previous data") {
      selectedValue = widget.stateControl.text.split(" ").first.toInt();
    } 
    return DropdownButton(
        value: selectedValue,
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("نشط"),
          ),
          DropdownMenuItem(
            value: 0,
            child: Text("مخفي"),
          ),
        ],
        onChanged: (value) {
          setState(() {
            if (value != null) {
              selectedValue = value;
              widget.stateControl.text = selectedValue.toString();
            }
          });
        });
  }
}

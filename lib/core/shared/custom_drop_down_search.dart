import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:ecommerce_private_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomDropDownSearch extends StatefulWidget {
  const CustomDropDownSearch(
      {super.key,
      required this.title,
      required this.categoriesIdControl,
      required this.data,
      required this.dropDownControl,
      this.enableMultipleSelection = false});
  final String title;
  final List<SelectedListItem> data;
  final bool enableMultipleSelection;
  final TextEditingController dropDownControl;
  final TextEditingController categoriesIdControl;

  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {
  void showDropDown() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: Text(
          S.of(context).onboarding_done,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.data,
        selectedItems: (List<dynamic> selectedList) {
          SelectedListItem selectedListItem = selectedList[0];
          widget.dropDownControl.text = selectedListItem.name;
          widget.categoriesIdControl.text = selectedListItem.value!;
        },
        enableMultipleSelection: widget.enableMultipleSelection,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        showDropDown();
      },
      keyboardType: TextInputType.none,
      readOnly: true,
      controller: widget.dropDownControl,
      decoration: InputDecoration(
          hintText: widget.dropDownControl.text == ""
              ? widget.title
              : widget.dropDownControl.text,
          hintStyle: const TextStyle(fontSize: 12),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(widget.dropDownControl.text == ""
                  ? widget.title
                  : widget.dropDownControl.text)),
          suffixIcon: IconButton(
              onPressed: () {
                showDropDown();
              },
              icon: const Icon(Icons.arrow_drop_down)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
    );
  }
}

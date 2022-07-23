import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class DropDownMenu extends StatelessWidget {

  String dropDownValue ;
  List<String> list ;
  final String? Function(String?)? onChanged;

  DropDownMenu({Key? key,required this.dropDownValue ,required this.list,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.shade200,
              width: .8),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
              Radius.circular(12))),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value: dropDownValue ,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15),
            onChanged:onChanged ,
            items: list
                .map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

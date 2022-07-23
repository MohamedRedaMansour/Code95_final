import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hint;
  final bool isEnabled ;
  final TextInputType? textInputType ;
  final void Function(String?)? onSaved;
  final void Function()? onTap;

  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  const CustomTextField({Key? key,required this.hint ,this.onChanged ,
    this.onSaved,this.onTap,this.validator,this.isEnabled = true , this.textInputType = TextInputType.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.only(start: 8),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            )),
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
      ),
      keyboardType: textInputType
    );
  }
}

import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

Widget textField(
  TextEditingController editingController,
  String Function(String) validator,
  String label,
  String hint,
  IconData icon,
  Function onSave,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
    child: TextFormField(
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      controller: editingController,
      validator: (value) => validator(value),
      textAlign: TextAlign.left,
      style: const TextStyle(color: kTextColourBlack),
      enableSuggestions: true,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.safeBlockHorizontal * 7.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kTertiaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(icon, color: kTextColourBlack),
        labelText: label,
        labelStyle: const TextStyle(color: kTextColourBlack),
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      onSaved: onSave,
    ),
  );
}

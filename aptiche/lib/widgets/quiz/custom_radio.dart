import 'package:aptiche/utils/enums.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.toggleable = false,
  }) : super(key: key);
  final bool toggleable;
  final String label;
  final EdgeInsets padding;
  final ChoicesEnum groupValue;
  final ChoicesEnum value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        } else
          onChanged(null);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<ChoicesEnum>(
              activeColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) =>
                      Theme.of(context).primaryColor),
              groupValue: groupValue,
              value: value,
              toggleable: toggleable,
              onChanged: (ChoicesEnum? newValue) {
                onChanged(newValue);
              },
            ),
            Flexible(
                child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText2,
            )),
          ],
        ),
      ),
    );
  }
}

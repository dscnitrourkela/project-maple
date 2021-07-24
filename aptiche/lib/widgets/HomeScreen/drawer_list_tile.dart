import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);
  final String text;
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal!,
        bottom: SizeConfig.safeBlockVertical!,
      ),
      child: ListTile(
        title: RichText(
            text: TextSpan(
          text: text,
          recognizer: TapGestureRecognizer()..onTap = function,
          style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
              ),
        )),
      ),
    );
  }
}

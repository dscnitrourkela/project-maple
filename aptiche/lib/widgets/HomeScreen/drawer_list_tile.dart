import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal!,
        bottom: SizeConfig.safeBlockVertical! * 2,
      ),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal! * 5,
              ),
        ),
      ),
    );
  }
}

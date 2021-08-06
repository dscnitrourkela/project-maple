import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';

class QuizTopBar extends StatelessWidget {
  const QuizTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //TODO: Decide if it's going to be a dropdown list or something else
          //and imlpement
          Text(
            '1 of 20',
            style: Theme.of(context).textTheme.headline6,
          ),
          CustomButton(
            text: 'Finish',
            onTap: () {},
            horizontalPadding: 7,
            verticalPadding: 2,
          )
        ],
      ),
    );
  }
}

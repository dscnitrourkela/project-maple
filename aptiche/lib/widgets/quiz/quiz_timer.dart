import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class QuizTimer extends StatelessWidget {
  const QuizTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: SizeConfig.safeBlockVertical! * 3.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.timer_rounded,
            size: SizeConfig.safeBlockHorizontal! * 4.5,
            color: Colors.white,
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal! * 1,
          ),
          Text(
            '59:47',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

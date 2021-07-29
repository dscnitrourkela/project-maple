import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! * 2),
      child: Text(
        '''Suppose S is a set of numbers that contain numbers where each number x is a non negative integer and 10^x divides 70!, how many such numbers are in S?''',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              height: SizeConfig.safeBlockHorizontal! * 0.4,
              fontSize: SizeConfig.safeBlockVertical! * 2,
            ),
      ),
    );
  }
}

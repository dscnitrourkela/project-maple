import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class QuizTimer extends GetView<QuizController> {
  const QuizTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
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
          Obx(
            () => Text(
              '${controller.timeout.value.inMinutes.remainder(60)} : ${controller.timeout.value.inSeconds.remainder(60)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

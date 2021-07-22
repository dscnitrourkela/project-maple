import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeGridTile extends StatelessWidget {
  HomeGridTile({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final HomeController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth! * 0.04,
        vertical: SizeConfig.screenWidth! * 0.04,
      ),
      decoration: BoxDecoration(
        color: kGreyBgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: SizeConfig.screenWidth! * 0.45,
      width: SizeConfig.screenWidth! * 0.45,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          Image.asset(
            Strings.quizPNG,
            width: SizeConfig.safeBlockHorizontal! * 15,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          Text(
            controller.quizzes[index].name.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.calendar_today),
              Text(formatDateTime(controller.quizzes[index].startTime)['date']
                  .toString()),
              const Icon(Icons.timelapse),
              Text(formatDateTime(controller.quizzes[index].startTime)['time']
                  .toString()),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          Text(
            '30 Questions, 60 mins',
            style: Theme.of(context)
                .primaryTextTheme
                .headline3!
                .copyWith(fontSize: SizeConfig.safeBlockHorizontal! * 3),
          ),
        ],
      ),
    );
  }
}

import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({
    Key? key,
  }) : super(key: key);

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
          const SizedBox(
            height: 10.0,
          ),
          Image.asset(quizPNG),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            'Aptitude Test-1',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.calendar_today),
              const Text('xx/xx/xxxx'),
              const Icon(Icons.timelapse),
              const Text('18:00'),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            '30 Questions, 60 mins',
            style: Theme.of(context)
                .primaryTextTheme
                .headline3!
                .copyWith(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

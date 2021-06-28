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
          Text(
            'Aptitude Test-1',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.calendar_today),
              Text('xx/xx/xxxx'),
              Icon(Icons.timelapse),
              Text('18:00'),
            ],
          ),
          SizedBox(
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

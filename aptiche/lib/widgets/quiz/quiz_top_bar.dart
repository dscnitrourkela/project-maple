import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal! * 7,
                vertical: SizeConfig.safeBlockHorizontal! * 2,
              ),
              elevation: SizeConfig.safeBlockHorizontal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SizeConfig.safeBlockVertical! * 2.125,
                ),
              ),
            ),
            child: Text(
              'Finish',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColourWhite,
                fontFamily: kSfpro,
                fontSize: SizeConfig.safeBlockVertical! * 2.125,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class AnswerDisplayer extends StatelessWidget {
  const AnswerDisplayer({
    Key? key,
    required this.question,
    required this.answer,
    required this.index,
  }) : super(key: key);
  final String question;
  final String answer;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal! * 1.5),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal! * 1.5,
                vertical: SizeConfig.safeBlockHorizontal! * 3.5,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 1.5,
                      vertical: SizeConfig.safeBlockHorizontal! * 3.5,
                    ),
                    child: Text(
                      '$index. $question',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal! * 4.25,
                            color: kTextColourBlack,
                          ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 8,
                      ),
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.maxFinite,
                    child: Text(
                      'Answer → $answer',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal! * 4.25,
                            color: kTextColourBlack,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: kPrimaryColor.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}

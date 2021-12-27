import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.rollNo,
  }) : super(key: key);

  final String name;
  final String email;
  final String phoneNo;
  final String rollNo;

  @override
  Widget build(BuildContext context) {
    final GetStorage localQuizStorage = GetStorage('Quiz');
    final Map<String, dynamic>? results = localQuizStorage.read('past');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          // color: kTextColourBlue,
          onPressed: () {
            Get.back<dynamic>();
          },
        ),
        centerTitle: false,
        // backgroundColor: kBgColour,
        title: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal!),
          child: Text(
            'Profile Dashboard',
            style: Theme.of(context)
                .primaryTextTheme
                .headline2!
                .copyWith(fontSize: SizeConfig.safeBlockVertical! * 3.5),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextDrawable(
              text: name,
              height: SizeConfig.safeBlockHorizontal! * 30,
              width: SizeConfig.safeBlockHorizontal! * 30,
              textStyle: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal! * 20,
                fontFamily: kSfpro,
                fontWeight: FontWeight.w700,
                color: kBgColour,
              ),
              backgroundColor: kTextColourBlue,
              boxShape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 1),
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    style:
                        Theme.of(context).primaryTextTheme.headline2!.copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal! * 8,
                              fontFamily: kSfpro,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockHorizontal! * 2.25),
                    child: Column(
                      children: <Widget>[
                        DetailCard(
                          data: rollNo,
                          icon: Icons.school_rounded,
                        ),
                        DetailCard(
                          data: email,
                          icon: Icons.email_rounded,
                        ),
                        DetailCard(
                          data: phoneNo,
                          icon: Icons.phone_rounded,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Past Attempted Quizzes',
                    style:
                        Theme.of(context).primaryTextTheme.headline2!.copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal! * 6.25,
                              fontFamily: kSfpro,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  if (results != null)
                    SingleChildScrollView(
                      child: SizedBox(
                        height: SizeConfig.screenHeight! * 0.35,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: results.values.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(results.keys.elementAt(index),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 14)),
                                trailing: Text(
                                  'score : ${results.values.elementAt(index)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 14),
                                ),
                              );
                            }),
                      ),
                    )
                  else
                    Center(
                      child: Text(
                        'You have not attempted any quiz in the past',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({Key? key, required this.data, required this.icon})
      : super(key: key);
  final String data;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal! * 1),
        width: double.infinity,
        color: kTertiaryColor.withOpacity(0.2),
        child: ListTile(
          title: Text(
            data,
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText1!
                .copyWith(fontSize: 16),
          ),
          leading: Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
        ));
  }
}

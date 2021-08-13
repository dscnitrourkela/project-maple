import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetStorage localUserStorage = GetStorage('User');
    final GetStorage localQuizStorage = GetStorage('Quiz');
    print(localQuizStorage);
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: kTextColourBlue,
          onPressed: () {
            Get.back<dynamic>();
          },
        ),
        centerTitle: false,
        backgroundColor: kBgColour,
        title: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal!),
          child: Text(
            'Profile Dashboard',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7,
                  color: kTextColourBlue,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextDrawable(
              text: localUserStorage.read<String?>('name').toString(),
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
                    localUserStorage.read<String?>('name').toString(),
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal! * 8,
                      fontFamily: kSfpro,
                      fontWeight: FontWeight.w500,
                      color: kTextColourBlue,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockHorizontal! * 2.25),
                    child: Column(
                      children: <Widget>[
                        DetailCard(
                          data: localUserStorage
                              .read<String?>('rollNo')
                              .toString(),
                          icon: Icons.school_rounded,
                        ),
                        DetailCard(
                          data: localUserStorage
                              .read<String?>('email')
                              .toString(),
                          icon: Icons.email_rounded,
                        ),
                        DetailCard(
                          data: localUserStorage
                              .read<String?>('phoneNo')
                              .toString(),
                          icon: Icons.phone_rounded,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Past Quizzes and Results',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal! * 6.25,
                      fontFamily: kSfpro,
                      fontWeight: FontWeight.w500,
                      color: kTextColourBlue,
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: SizeConfig.screenHeight! * 0.35,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text('quiz $index name veryyyy long name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 14)),
                              subtitle: Text('$index | 08 | 2021'),
                              trailing: Text(
                                'score : $index',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                              ),
                            );
                          }),
                    ),
                  )
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
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
          leading: Icon(
            icon,
            color: kTextColourBlue.withOpacity(0.8),
          ),
        ));
  }
}

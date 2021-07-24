import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/home_controller.dart';
import 'package:aptiche/widgets/HomeScreen/drawer.dart';
import 'package:aptiche/widgets/HomeScreen/home_screen_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController().init();
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: kGreyBgColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            color: kTextColourBlue,
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
            iconSize: 30.0,
          ),
        ),
        title: Text(
          'Apti-Che',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
      ),
      backgroundColor: kGreyBgColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: SizeConfig.screenHeight! * 0.500,
            left: SizeConfig.screenWidth! * 0.175,
            right: SizeConfig.screenWidth! * 0.175,
            child: SvgPicture.asset(
              Strings.homeScreenSVG,
              alignment: Alignment.center,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
              height: SizeConfig.screenHeight! * 0.32,
            ),
          ),
          DraggableScrollableSheet(
            builder: (BuildContext context, ScrollController scrollController) {
              return SizedBox(
                height: SizeConfig.screenHeight! * 0.45,
                width: SizeConfig.screenWidth,
                child: Obx(
                  () => Container(
                    height: SizeConfig.screenHeight! * 0.4,
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical! * 4,
                    ),
                    decoration: BoxDecoration(
                      color: kBgColour,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.safeBlockHorizontal! * 10,
                        ),
                        topRight: Radius.circular(
                          SizeConfig.safeBlockHorizontal! * 10,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      // physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth! * 0.1,
                            ),
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () =>
                                      controller.upcomingQuizzes.value = true,
                                  child: Container(
                                    width: SizeConfig.screenWidth! * 0.4,
                                    height: SizeConfig.screenHeight! * 0.06,
                                    decoration: BoxDecoration(
                                      color: controller.upcomingQuizzes.value
                                          ? Theme.of(context).primaryColor
                                          : kGreyBgColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Upcoming Quizzes',
                                        textAlign: TextAlign.center,
                                        style: !controller.upcomingQuizzes.value
                                            ? Theme.of(context)
                                                .primaryTextTheme
                                                .headline3
                                            : Theme.of(context)
                                                .primaryTextTheme
                                                .headline3!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.upcomingQuizzes.value = false;
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth! * 0.4,
                                    height: SizeConfig.screenHeight! * 0.06,
                                    decoration: BoxDecoration(
                                      color: !controller.upcomingQuizzes.value
                                          ? Theme.of(context).primaryColor
                                          : kGreyBgColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Past Quizzes',
                                        textAlign: TextAlign.center,
                                        style: controller.upcomingQuizzes.value
                                            ? Theme.of(context)
                                                .primaryTextTheme
                                                .headline3
                                            : Theme.of(context)
                                                .primaryTextTheme
                                                .headline3!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisCount: 2,
                            children: List<Widget>.generate(
                              9,
                              (int index) => const HomeGridTile(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

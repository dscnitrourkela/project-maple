import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {Key? key,
      required this.name,
      required this.contact,
      required this.context,
      required this.thirdPartyServices})
      : super(key: key);
  final String name;
  final String contact;
  final BuildContext context;
  final ThirdPartyServices thirdPartyServices;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (contact != '') {
            thirdPartyServices.urlLauncher(contact);
          } else {}
        },
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal! * 5,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Text(
                  contact,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 4,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

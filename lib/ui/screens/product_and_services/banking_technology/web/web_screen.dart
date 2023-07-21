import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class WebCollectionDescScreen extends StatefulWidget {
  const WebCollectionDescScreen({Key? key}) : super(key: key);

  @override
  State<WebCollectionDescScreen> createState() => _WebCollectionDescScreenState();
}

class _WebCollectionDescScreenState extends State<WebCollectionDescScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.bodyLarge?.merge(
      Styles.customTextStyle4(
        fontSize: responsiveSize(context, 64, 80, md: 76),
        height: 1.25,
        color: AppColors.black,
      ),
    );
    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: EdgeInsets.only(left: Sizes.PADDING_100),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.maroon07.withOpacity(0.9),
                AppColors.maroon06.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxH70(),
              Text(
                StringConst.WEB_COLLECTION_TITLE,
                style: titleStyle,
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxH40(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 60),
                  padding: EdgeInsets.only(
                    left: Sizes.PADDING_100,
                    right: Sizes.PADDING_100,
                  ),
                  child: Text(
                    StringConst.WEB_COLLECTION_DESC,
                    style: textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/productservices_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/kplus_desc.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/insights_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/project_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/skill_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/skill_level.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {
  static List<SocialButtonData> socialData = [
    SocialButtonData(
      tag: StringConst.LINKED_IN_URL,
      iconData: FontAwesomeIcons.linkedin,
      url: StringConst.LINKED_IN_URL,
    ),
    SocialButtonData(
      tag: StringConst.GITHUB_URL,
      iconData: FontAwesomeIcons.github,
      url: StringConst.GITHUB_URL,
    ),
    SocialButtonData(
      tag: StringConst.FACEBOOK_URL,
      iconData: FontAwesomeIcons.facebook,
      url: StringConst.FACEBOOK_URL,
    ),
    SocialButtonData(
      tag: StringConst.INSTA,
      iconData: FontAwesomeIcons.instagram,
      url: StringConst.INSTAGRAM_URL,
    ),
    SocialButtonData(
      tag: StringConst.TWITTER_URL,
      iconData: FontAwesomeIcons.twitter,
      url: StringConst.TWITTER_URL,
    ),
  ];
  static List<FooterSocialButtonData> socialfooterData = [
    FooterSocialButtonData(
      tag: StringConst.LINKED_IN_URL,
      iconData: FontAwesomeIcons.linkedin,
      iconColor: AppColors.white,
      url: StringConst.LINKED_IN_URL,
    ),
    FooterSocialButtonData(
      tag: StringConst.GITHUB_URL,
      iconData: FontAwesomeIcons.github,
      iconColor: AppColors.white,
      url: StringConst.GITHUB_URL,
    ),
    FooterSocialButtonData(
      tag: StringConst.FACEBOOK_URL,
      iconData: FontAwesomeIcons.facebook,
      iconColor: AppColors.white,
      url: StringConst.FACEBOOK_URL,
    ),
    FooterSocialButtonData(
      tag: StringConst.INSTA,
      iconData: FontAwesomeIcons.instagram,
      url: StringConst.INSTAGRAM_URL,
    ),
    FooterSocialButtonData(
      tag: StringConst.TWITTER_URL,
      iconData: FontAwesomeIcons.twitter,
      url: StringConst.TWITTER_URL,
    ),
  ];

  static List<SkillLevelData> skillLevelData = [
    SkillLevelData(
      skill: StringConst.SKILLS_1,
      level: 80,
    ),
    SkillLevelData(
      skill: StringConst.SKILLS_2,
      level: 90,
    ),
    SkillLevelData(
      skill: StringConst.SKILLS_3,
      level: 70,
    ),
  ];

  static List<SkillCardData> skillCardData = [
    SkillCardData(
      title: StringConst.SKILLS_1,
      description: StringConst.SKILLS_1_DESC,
      iconData: FontAwesomeIcons.compress,
    ),
    SkillCardData(
      title: "",
      description: "",
      iconData: Icons.pages_outlined,
    ), //not being used
    SkillCardData(
      title: StringConst.SKILLS_2,
      description: StringConst.SKILLS_2_DESC,
      iconData: Icons.pages_outlined,
    ),
    SkillCardData(
      title: StringConst.SKILLS_3,
      description: StringConst.SKILLS_3_DESC,
      iconData: FontAwesomeIcons.paintBrush,
    ),
    SkillCardData(
      title: StringConst.SKILLS_4,
      description: StringConst.SKILLS_4_DESC,
      iconData: FontAwesomeIcons.recordVinyl,
    ),
    SkillCardData(
      title: "",
      description: "",
      iconData: Icons.pages_outlined,
    ), //not being used
  ];
  // static List<StatItemData> statItemsData = [
  //   StatItemData(value: 120, subtitle: StringConst.HAPPY_CLIENTS),
  //   StatItemData(value: 10, subtitle: StringConst.YEARS_OF_EXPERIENCE),
  //   StatItemData(value: 230, subtitle: StringConst.INCREDIBLE_PROJECTS),
  //   StatItemData(value: 18, subtitle: StringConst.AWARD_WINNING),
  // ];
  //
  // static List<StatItemData> statItemsData2 = [
  //   StatItemData(value: 1000, subtitle: StringConst.API_CALLS_PER_DAY),
  //   StatItemData(value: 65, subtitle: StringConst.COUNTRIES),
  //   StatItemData(value: 230, subtitle: StringConst.INCREDIBLE_PROJECTS),
  //   StatItemData(value: 18, subtitle: StringConst.AWARD_WINNING),
  // ];

  static List<ProductServicesCategoryData> productServicesCategories = [
    ProductServicesCategoryData(
      title: StringConst.ALL,
      number: 6,
      isSelected: true,
    ),
    ProductServicesCategoryData(
      title: StringConst.MOBILE_APP,
      number: 2,
      isSelected: true,
    ),
    ProductServicesCategoryData(
      title: StringConst.WEB,
      number: 1,
      isSelected: true,
    ),
    ProductServicesCategoryData(
      title: StringConst.ATM,
      number: 2,
      isSelected: true,
    ),
    ProductServicesCategoryData(
      title: StringConst.WEB_DESIGN,
      number: 3,
      isSelected: true,
    ),
  ];

  static List<String> awards1 = [
    StringConst.AWARDS_1,
    StringConst.AWARDS_2,
    StringConst.AWARDS_3,
    StringConst.AWARDS_4,
    StringConst.AWARDS_5,
  ];
  static List<String> awards2 = [
    StringConst.AWARDS_6,
    StringConst.AWARDS_7,
    StringConst.AWARDS_8,
    StringConst.AWARDS_9,
    StringConst.AWARDS_10,
  ];
  static List<InsightsData> insightsData = [
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_1,
      title: StringConst.ARTICLE_TITLE_1,
      subtitle: StringConst.ARTICLE_SUBTITLE_1,
      date: StringConst.ARTICLE_DATE,
      buttonText: StringConst.ARTICLE_READ_MORE,
      imageUrl: ImagePath.ARTICLE_01,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_2,
      title: StringConst.EVENTS_TITLE_1,
      subtitle: StringConst.EVENTS_SUBTITLE_2,
      date: StringConst.EVENTS_DATE,
      buttonText: StringConst.EVENTS_READ_MORE,
      imageUrl: ImagePath.EVENTS_02,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_3,
      title: StringConst.WEBINARS_TITLE_1,
      subtitle: StringConst.WEBINARS_SUBTITLE_3,
      date: StringConst.WEBINARS_DATE,
      buttonText: StringConst.WEBINARS_READ_MORE,
      imageUrl: ImagePath.WEBINARS_01,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_1,
      title: StringConst.ARTICLE_TITLE_1,
      subtitle: StringConst.ARTICLE_SUBTITLE_1,
      date: StringConst.ARTICLE_DATE,
      buttonText: StringConst.ARTICLE_READ_MORE,
      imageUrl: ImagePath.ARTICLE_01,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_2,
      title: StringConst.EVENTS_TITLE_1,
      subtitle: StringConst.EVENTS_SUBTITLE_2,
      date: StringConst.EVENTS_DATE,
      buttonText: StringConst.EVENTS_READ_MORE,
      imageUrl: ImagePath.EVENTS_02,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_3,
      title: StringConst.WEBINARS_TITLE_1,
      subtitle: StringConst.WEBINARS_SUBTITLE_3,
      date: StringConst.WEBINARS_DATE,
      buttonText: StringConst.WEBINARS_READ_MORE,
      imageUrl: ImagePath.WEBINARS_01,
    ),
  ];

  static List<FdsTagLineCardData> fdsTagLineCardData = [
    FdsTagLineCardData(
      title: StringConst.WE_LISTEN,
      titleColor: AppColors.maroon03,
      // leadingIcon: Icons.done,
      // trailingIcon: Icons.chevron_right,
    ),
    FdsTagLineCardData(
      title: StringConst.WE_ANTICIPATE,
      titleColor: AppColors.maroon03,
      // leadingIcon: Icons.done,
      // trailingIcon: Icons.chevron_right,
    ),
    FdsTagLineCardData(
      title: StringConst.WE_DELIVER,
      titleColor: AppColors.maroon03,
      // leadingIcon: Icons.done,
      // trailingIcon: Icons.chevron_right,
    ),
  ];

  static List<ProductServicesData> allProductServices = [
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.AML,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.ATM_SWITCH_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.CHATBOT_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.CLOUD_TEST_ENVIRONMENT_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.CORE_BANKING_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.DCM_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {
        kPlusDescriptionScreen();
        print('---------------------');
      },
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.KPLUS_GREEN_WHITEBG,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {
        kPlusDescriptionScreen();
        print('---------------------');
      },
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.KONEK2CARD_GREEN,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.MOBILE_APP,
      productServicesCoverUrl: ImagePath.MOBILE_COLLECTION_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.OPEN_API_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.SMART_BRANCH_SYSTEM_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.MOBILE_APP,
      productServicesCoverUrl: ImagePath.TEMENOS_MAROON,
      width: 0.225,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.WEB_COLLECTION_MAROON,
      width: 0.225,
    ),
  ];
  static List<ProductServicesData> mobileProductServices = [
    ProductServicesData(
      onPressed: () {},
      productServicesCoverUrl: ImagePath.KPLUS_MAROON_WHITEBG,
      width: 0.220,
      mobileHeight: 0.3,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.MOBILE_APP,
      productServicesCoverUrl: ImagePath.CHATBOT_MAROON,
      width: 0.220,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.MOBILE_APP,
      productServicesCoverUrl: ImagePath.MOBILE_COLLECTION_MAROON,
      width: 0.225,
    ),
  ];
  static List<ProductServicesData> webProductServices = [
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.DCM_MAROON,
      width: 0.220,
    ),
  ];
  static List<ProductServicesData> atmProductServices = [
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.KPLUS_GREEN_WHITEBG,
      width: 0.220,
      mobileHeight: 0.3,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.WEB_COLLECTION_MAROON,
      width: 0.220,
      mobileHeight: 0.3,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.ATM,
      productServicesCoverUrl: ImagePath.ATM_SWITCH_MAROON,
      width: 0.225,
    ),
  ];
  static List<ProductServicesData> dcmProductServices = [
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.CHATBOT_GREEN,
      width: 0.220,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.OPEN_API_MAROON,
      width: 0.220,
    ),
    ProductServicesData(
      onPressed: () {},
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.DCM_MAROON,
      width: 0.220,
    ),
  ];
}

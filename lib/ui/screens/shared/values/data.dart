import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/leading_partners_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/insights_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/project_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {
  static List<SocialButtonData> socialData = [
    SocialButtonData(
      tag: StringConst.LINKED_IN_URL,
      iconData: FontAwesomeIcons.linkedin,
      url: StringConst.LINKED_IN_URL,
    ),
    SocialButtonData(
      tag: StringConst.FACEBOOK_URL,
      iconData: FontAwesomeIcons.facebook,
      url: StringConst.FACEBOOK_URL,
    ),
    SocialButtonData(
      tag: StringConst.GITHUB_URL,
      iconData: FontAwesomeIcons.github,
      url: StringConst.GITHUB_URL,
    ),
    SocialButtonData(
      tag: StringConst.INSTAGRAM_URL,
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
      tag: StringConst.FACEBOOK_URL,
      iconData: FontAwesomeIcons.facebook,
      iconColor: AppColors.white,
      url: StringConst.FACEBOOK_URL,
    ),
  ];

  static List<StatItemData> statItemsData = [
    StatItemData(
      value: 8,
      values: "M+",
      subtitle: StringConst.CLIENTS,
    ),
    StatItemData(
      value: 10,
      values: "",
      subtitle: StringConst.YEARS_OF_EXPERIENCE,
    ),
    StatItemData(
      value: 4,
      values: "",
      subtitle: StringConst.COUNTRIES,
    ),
    // StatItemData(
    //   value: 18,
    //   subtitle: StringConst.AWARD_WINNING,
    // ),
  ];

  static List<StatItemData> statItemsData2 = [
    StatItemData(
      value: 1000,
      subtitle: StringConst.API_CALLS_PER_DAY,
    ),
    StatItemData(
      value: 65,
      subtitle: StringConst.COUNTRIES,
    ),
    StatItemData(
      value: 230,
      subtitle: StringConst.INCREDIBLE_PROJECTS,
    ),
    StatItemData(
      value: 18,
      subtitle: StringConst.AWARD_WINNING,
    ),
  ];

  static List<ProductServicesCategoryData> productServicesCategories = [
    ProductServicesCategoryData(
      title: StringConst.ALL,
      number: 13,
      isSelected: true,
    ),
    // ProductServicesCategoryData(
    //   title: StringConst.MOBILE_APP,
    //   number: 2,
    //   isSelected: true,
    // ),
    // ProductServicesCategoryData(
    //   title: StringConst.WEB,
    //   number: 1,
    //   isSelected: true,
    // ),
    // ProductServicesCategoryData(
    //   title: StringConst.ATM,
    //   number: 2,
    //   isSelected: true,
    // ),
    // ProductServicesCategoryData(
    //   title: StringConst.WEB_DESIGN,
    //   number: 3,
    //   isSelected: true,
    // ),
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
      // buttonText: StringConst.ARTICLE_READ_MORE,
      imageUrl: ImagePath.ARTICLE_CARD_COVER,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_2,
      title: StringConst.EVENTS_TITLE_1,
      subtitle: StringConst.EVENTS_SUBTITLE_1,
      date: StringConst.EVENTS_DATE,
      //  buttonText: StringConst.EVENTS_READ_MORE,
      imageUrl: ImagePath.EVENTS_CARD_COVER,
    ),
    InsightsData(
      category: StringConst.INSIGHTS_CATEGORY_3,
      title: StringConst.WEBINARS_TITLE_1,
      subtitle: StringConst.WEBINARS_SUBTITLE_1,
      date: StringConst.WEBINARS_DATE,
      // buttonText: StringConst.WEBINARS_READ_MORE,
      imageUrl: ImagePath.WEBINARS_CARD_COVER,
    ),
    // InsightsData(
    //   category: StringConst.INSIGHTS_CATEGORY_1,
    //   title: StringConst.ARTICLE_TITLE_1,
    //   subtitle: StringConst.ARTICLE_SUBTITLE_1,
    //   date: StringConst.ARTICLE_DATE,
    //   // buttonText: StringConst.ARTICLE_READ_MORE,
    //   imageUrl: ImagePath.ARTICLE_01,
    // ),
    // InsightsData(
    //   category: StringConst.INSIGHTS_CATEGORY_2,
    //   title: StringConst.EVENTS_TITLE_1,
    //   subtitle: StringConst.EVENTS_SUBTITLE_2,
    //   date: StringConst.EVENTS_DATE,
    //   // buttonText: StringConst.EVENTS_READ_MORE,
    //   imageUrl: ImagePath.EVENTS_02,
    // ),
    // InsightsData(
    //   category: StringConst.INSIGHTS_CATEGORY_3,
    //   title: StringConst.WEBINARS_TITLE_1,
    //   subtitle: StringConst.WEBINARS_SUBTITLE_3,
    //   date: StringConst.WEBINARS_DATE,
    //   // buttonText: StringConst.WEBINARS_READ_MORE,
    //   imageUrl: ImagePath.WEBINARS_01,
    // ),
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
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.BANKING_TECHNOLOGY_GIF,
      width: 0.225,
    ),
    ProductServicesData(
      productServicesCoverUrl: ImagePath.ALTERNATIVE_SOLUTION_GIF,
      width: 0.220,
      mobileHeight: 0.3,
    ),
    ProductServicesData(
      productServicesCoverUrl: ImagePath.REGULATORY_SECURITY_GIF,
      width: 0.220,
      mobileHeight: 0.3,
    ),
    ProductServicesData(
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.SOFTWARE_SERVICE_GIF,
      width: 0.225,
    ),
  ];
  // static List<ProductServicesData> mobileProductServices = [
  //   ProductServicesData(
  //     productServicesCoverUrl: ImagePath.KPLUS_MAROON_WHITEBG,
  //     width: 0.220,
  //     mobileHeight: 0.3,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.MOBILE_APP,
  //     productServicesCoverUrl: ImagePath.CHATBOT_MAROON,
  //     width: 0.220,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.MOBILE_APP,
  //     productServicesCoverUrl: ImagePath.MOBILE_COLLECTION_MAROON,
  //     width: 0.225,
  //   ),
  // ];
  // static List<ProductServicesData> webProductServices = [
  //   ProductServicesData(
  //     category: StringConst.WEB,
  //     productServicesCoverUrl: ImagePath.DCM_MAROON,
  //     width: 0.220,
  //   ),
  // ];
  // static List<ProductServicesData> atmProductServices = [
  //   ProductServicesData(
  //     category: StringConst.ATM,
  //     productServicesCoverUrl: ImagePath.KPLUS_GREEN_WHITEBG,
  //     width: 0.220,
  //     mobileHeight: 0.3,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.ATM,
  //     productServicesCoverUrl: ImagePath.WEB_COLLECTION_MAROON,
  //     width: 0.220,
  //     mobileHeight: 0.3,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.ATM,
  //     productServicesCoverUrl: ImagePath.ATM_SWITCH_MAROON,
  //     width: 0.225,
  //   ),
  // ];
  // static List<ProductServicesData> dcmProductServices = [
  //   ProductServicesData(
  //     category: StringConst.WEB_DESIGN,
  //     productServicesCoverUrl: ImagePath.CHATBOT_MAROON,
  //     width: 0.220,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.WEB_DESIGN,
  //     productServicesCoverUrl: ImagePath.OPEN_API_MAROON,
  //     width: 0.220,
  //   ),
  //   ProductServicesData(
  //     category: StringConst.WEB,
  //     productServicesCoverUrl: ImagePath.DCM_MAROON,
  //     width: 0.220,
  //   ),
  // ];
}

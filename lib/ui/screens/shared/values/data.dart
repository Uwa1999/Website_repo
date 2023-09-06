import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/insights_data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/leading_partner_data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/project_data.dart';
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

  static List<LeadingBankingPartnerData> LeadingBankingPartnerItemsData = [
    LeadingBankingPartnerData(
      value: 8,
      values: "M+",
      subtitle: StringConst.CLIENTS,
    ),
    LeadingBankingPartnerData(
      value: 10,
      values: "",
      subtitle: StringConst.YEARS_OF_EXPERIENCE,
    ),
    LeadingBankingPartnerData(
      value: 4,
      values: "",
      subtitle: StringConst.COUNTRIES,
    ),
  ];

  static List<LeadingBankingPartnerData> statItemsData2 = [
    LeadingBankingPartnerData(
      value: 1000,
      subtitle: StringConst.API_CALLS_PER_DAY,
    ),
    LeadingBankingPartnerData(
      value: 65,
      subtitle: StringConst.COUNTRIES,
    ),
    LeadingBankingPartnerData(
      value: 230,
      subtitle: StringConst.INCREDIBLE_PROJECTS,
    ),
    LeadingBankingPartnerData(
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
  static List<DesktopInsightsData> insightsData = [
    DesktopInsightsData(
      category: StringConst.INSIGHTS_CATEGORY_1,
      title: StringConst.ARTICLE_TITLE_1,
      subtitle: StringConst.ARTICLE_SUBTITLE_1,
      date: StringConst.ARTICLE_DATE,
      imageUrl: ImagePath.ARTICLE_CARD_COVER,
    ),
    DesktopInsightsData(
      category: StringConst.INSIGHTS_CATEGORY_2,
      title: StringConst.EVENTS_TITLE_1,
      subtitle: StringConst.EVENTS_SUBTITLE_1,
      date: StringConst.EVENTS_DATE,
      imageUrl: ImagePath.EVENTS_CARD_COVER,
    ),
    DesktopInsightsData(
      category: StringConst.INSIGHTS_CATEGORY_3,
      title: StringConst.WEBINARS_TITLE_1,
      subtitle: StringConst.WEBINARS_SUBTITLE_1,
      date: StringConst.WEBINARS_DATE,
      imageUrl: ImagePath.WEBINARS_CARD_COVER,
    ),
  ];

  static List<DesktopProductServicesData> allProductServices = [
    DesktopProductServicesData(
      category: StringConst.WEB_DESIGN,
      productServicesCoverUrl: ImagePath.BANKING_TECHNOLOGY_GIF,
      width: 0.220,
    ),
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.ALTERNATIVE_SOLUTION_GIF,
      width: 0.220,
      // mobileHeight: 0.3,
    ),
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.REGULATORY_SECURITY_GIF,
      width: 0.220,
      //  mobileHeight: 0.3,
    ),
    DesktopProductServicesData(
      category: StringConst.WEB,
      productServicesCoverUrl: ImagePath.SOFTWARE_SERVICE_GIF,
      width: 0.220,
    ),
  ];
}

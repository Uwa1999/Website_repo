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

  static List<ProductServicesCategoryData> productServicesCategories = [
    ProductServicesCategoryData(
      title: StringConst.ALL,
      number: 13,
      isSelected: true,
    ),
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
      title: StringConst.NEWS_TITLE_1,
      subtitle: StringConst.NEWS_SUBTITLE_1,
      date: StringConst.NEWS_DATE,
      imageUrl: ImagePath.NEWS_CARD_COVER,
    ),
  ];

  static List<DesktopProductServicesData> allProductServices = [
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.BANKING_TECHNOLOGY_GIF,
      width: 0.220,
    ),
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.ALTERNATIVE_SOLUTION_GIF,
      width: 0.220,
    ),
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.REGULATORY_SECURITY_GIF,
      width: 0.220,
    ),
    DesktopProductServicesData(
      productServicesCoverUrl: ImagePath.SOFTWARE_SERVICE_GIF,
      width: 0.220,
    ),
  ];
}

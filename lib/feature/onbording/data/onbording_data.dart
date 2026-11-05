import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/feature/onbording/model/onbordin_model.dart';

class OnbordingData {
  static final List<OnbordingModel> onboardingList = [
    OnbordingModel(
      image: AppImage.image1,
      title: "explan_title".tr(),
      description: "explan_desc".tr(),
    ),

    OnbordingModel(
      image: AppImage.image2,
      title: "explan2_title".tr(),
      description: "explan2_desc".tr(),
    ),

    OnbordingModel(
      image: AppImage.image3,
      title: "explan3_title".tr(),
      description: "explan3_desc".tr(),
    ),
  ];
}

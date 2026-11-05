import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnbordingScreens extends StatefulWidget {
  OnbordingScreens({super.key});
  static const String routeName = '/onbordingScreens';

  @override
  State<OnbordingScreens> createState() => _OnbordingScreensState();
}

class _OnbordingScreensState extends State<OnbordingScreens> {
  String selectedLanguage = 'EN';
  String selectedTheme = 'light';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          height: 700,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImage.evently,
                  color: provider.themeMode == ThemeMode.dark
                      ? AppColor.darkmodeblue
                      : null,
                  height: 27,
                  width: 142,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 5,
                    right: 5,
                    bottom: 5,
                  ),
                  child: Image.asset(
                    AppImage.beingCreative,
                    color: provider.themeMode == ThemeMode.dark
                        ? AppColor.whiteColor
                        : null,
                    height: 335,
                    width: 343,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "onbording_title".tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: provider.themeMode == ThemeMode.dark
                            ? provider.colors.primaryColor()
                            : AppColor.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "onbording_desc".tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.themeMode == ThemeMode.dark
                            ? provider.colors.greyColor()
                            : AppColor.grayColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "language".tr(),
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: provider.colors.primaryColor(),
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          context.setLocale(Locale('en'));
                          setState(() {
                            selectedLanguage = 'EN';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedLanguage == 'EN'
                              ? (provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.blueColor)
                              : (provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmode
                                    : AppColor.whiteColor),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "english".tr(),
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: selectedLanguage == 'EN'
                                    ? (provider.themeMode == ThemeMode.dark
                                          ? AppColor.whiteColor
                                          : AppColor.whiteColor)
                                    : (provider.themeMode == ThemeMode.dark
                                          ? AppColor.whiteColor
                                          : AppColor.blueColor),
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        context.setLocale(Locale('ar'));
                        setState(() {
                          selectedLanguage = 'AR';
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLanguage == 'AR'
                            ? (provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.blueColor)
                            : (provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmode
                                  : AppColor.whiteColor),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "arabic".tr(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedLanguage == 'AR'
                              ? (provider.themeMode == ThemeMode.dark
                                    ? AppColor.whiteColor
                                    : AppColor.whiteColor)
                              : (provider.themeMode == ThemeMode.dark
                                    ? AppColor.whiteColor
                                    : AppColor.blueColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "theme".tr(),
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: provider.colors.primaryColor(),
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          provider.changeTheme(ThemeMode.light);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.themeMode == ThemeMode.light
                              ? AppColor.blueColor
                              : AppColor.darkmode,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        child: Image.asset(
                          AppImage.sun,
                          color: provider.themeMode == ThemeMode.light
                              ? AppColor.whiteColor
                              : AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          provider.changeTheme(ThemeMode.dark);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : AppColor.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadowColor: AppColor.grayLightColor,
                        ),

                        child: Image.asset(
                          AppImage.moon,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.whiteColor
                              : AppColor.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                            context,
                            RouteApp.introdactionScreen,
                          );
                        },

                        child: Text(
                          "let's_start".tr(),
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: AppColor.whiteColor,
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

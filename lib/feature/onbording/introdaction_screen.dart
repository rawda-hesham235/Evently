import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/core/text/app_style.dart';
import 'package:evently/feature/onbording/data/onbording_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntrodactionScreen extends StatefulWidget {
  const IntrodactionScreen({super.key});

  @override
  State<IntrodactionScreen> createState() => _IntrodactionScreenState();
}

class _IntrodactionScreenState extends State<IntrodactionScreen> {
  int currentIndex = 0;

  final PageController pageController = PageController();
  Future<void> finishIntroduction() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isFirstTime', false);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, RouteApp.logIn);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex == 0
                        ? SizedBox(width: 40)
                        : ElevatedButton(
                            autofocus: false,
                            onPressed: () {
                              if (currentIndex > 0) {
                                pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColor.whiteColor
                                  : AppColor.blueColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(15, 15),
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmode
                                  : AppColor.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),

                    Expanded(
                      child: Center(
                        child: Image.asset(
                          AppImage.evently,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : null,
                          height: 27,
                          width: 152,
                        ),
                      ),
                    ),
                    currentIndex == OnbordingData.onboardingList.length - 1
                        ? SizedBox(width: 10)
                        : ElevatedButton(
                            onPressed: finishIntroduction,
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmode
                                  : AppColor.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "skip".tr(),
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: provider.colors.primaryColor(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                    SizedBox(width: 10),
                  ],
                ),
                Container(
                  height: 343,
                  width: 343,
                  child: PageView(
                    controller: pageController,

                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },

                    children: OnbordingData.onboardingList.map((item) {
                      return Image.asset(
                        item.image,
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.whiteColor
                            : null,
                      );
                    }).toList(),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(OnbordingData.onboardingList.length, (
                    index,
                  ) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: currentIndex == index ? 20.92 : 8,
                      height: currentIndex == index ? 10 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: currentIndex == index
                            ? (provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.blueColor)
                            : (provider.themeMode == ThemeMode.dark
                                  ? AppColor.grayLightColor
                                  : AppColor.grayLightColor),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 20),

                Text(
                  OnbordingData.onboardingList[currentIndex].title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: provider.themeMode == ThemeMode.dark
                        ? provider.colors.primaryColor()
                        : AppColor.black,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  OnbordingData.onboardingList[currentIndex].description,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: provider.colors.greyColor(),
                  ),
                ),

                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (currentIndex < OnbordingData.onboardingList.length - 1) {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    finishIntroduction();
                  }
                },

                child: currentIndex == OnbordingData.onboardingList.length - 1
                    ? Text(
                        "get_started".tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    : Text(
                        "next".tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

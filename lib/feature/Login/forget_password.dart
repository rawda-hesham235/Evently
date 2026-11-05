import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/core/text/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    backgroundColor: provider.themeMode == ThemeMode.dark
                        ? AppColor.darkmode
                        : AppColor.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: provider.themeMode == ThemeMode.dark
                          ? AppColor.blueColor
                          : AppColor.whiteColor,
                      width: 1,
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      "forget_password_title".tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: provider.themeMode == ThemeMode.dark
                            ? provider.colors.primaryColor()
                            : AppColor.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Image.asset(AppImage.forgetPassword),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, RouteApp.buttomTab);
                    },

                    child: Text(
                      "reset_password".tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

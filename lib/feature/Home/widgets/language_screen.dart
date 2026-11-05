import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
                        "language".tr(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.whiteColor
                              : AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  "english".tr(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: provider.themeMode == ThemeMode.dark
                        ? AppColor.whiteColor
                        : AppColor.black,
                  ),
                ),
                leading: Radio<Locale>(
                  value: Locale('en'),
                  activeColor: provider.themeMode == ThemeMode.dark
                      ? AppColor.whiteColor
                      : AppColor.blueColor,
                  groupValue: context.locale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      context.setLocale(value);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "arabic".tr(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: provider.themeMode == ThemeMode.dark
                        ? AppColor.whiteColor
                        : AppColor.black,
                  ),
                ),
                leading: Radio<Locale>(
                  value: Locale('ar'),
                  activeColor: provider.themeMode == ThemeMode.dark
                      ? AppColor.whiteColor
                      : AppColor.blueColor,
                  groupValue: context.locale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      context.setLocale(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

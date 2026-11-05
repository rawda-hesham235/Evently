import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/my_provider.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/feature/Home/widgets/cards.dart';
import 'package:evently/feature/Home/widgets/category_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedId = CategoryModel.all.id;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<MyProvider>(context);

    return Container(
      color: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "welcome_back".tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: provider.themeMode == ThemeMode.dark
                                  ? provider.colors.primaryColor()
                                  : AppColor.grayColor,
                            ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user?.displayName ?? userProvider.userModel?.name ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: provider.themeMode == ThemeMode.dark
                              ? provider.colors.primaryColor()
                              : AppColor.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      provider.themeMode == ThemeMode.dark
                          ? Image.asset(AppImage.moon)
                          : Image.asset(AppImage.sunHome),
                      SizedBox(width: 20),
                      context.locale.languageCode == "en"
                          ? Image.asset(AppImage.language)
                          : Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.blueColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "AR",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color:
                                            provider.themeMode == ThemeMode.dark
                                            ? AppColor.whiteColor
                                            : AppColor.whiteColor,
                                      ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 46,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: CategoryModel.filters.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = CategoryModel.filters[index];
                      return CategoryEvent(
                        categories: category,
                        isSelected: selectedId == category.id,
                        onTap: () {
                          setState(() {
                            selectedId = category.id;
                          });
                        },
                      ).categoryButton(context);
                    },
                  ),
                ),
              ),

              SizedBox(height: 10),
              Expanded(child: Cards(selectedCategoryId: selectedId)),
            ],
          ),
        ),
      ),
    );
  }
}

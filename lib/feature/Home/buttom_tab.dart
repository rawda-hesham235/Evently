import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/feature/Home/Tabs/favoriet_screen.dart';
import 'package:evently/feature/Home/Tabs/home_screen.dart';
import 'package:evently/feature/Home/Tabs/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtomTab extends StatefulWidget {
  const ButtomTab({super.key});

  @override
  State<ButtomTab> createState() => _ButtomTabState();
}

class _ButtomTabState extends State<ButtomTab> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeScreen(), FavorietScreen(), Profile()];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          tabs[selectedIndex],
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteApp.addEvent);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: provider.themeMode == ThemeMode.dark
                    ? AppColor.darkmodeblue
                    : AppColor.blueColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blueColor,
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "+",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomAppBar(
          color: provider.themeMode == ThemeMode.dark
              ? AppColor.darkmode
              : AppColor.babyblue,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          notchMargin: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildNavItem(icon: AppImage.home, index: 0, label: "home".tr()),
              buildNavItem(
                iconData: Icons.favorite,
                index: 1,
                label: "favorites".tr(),
              ),
              buildNavItem(
                icon: AppImage.user,
                index: 2,
                label: "profile".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    String? icon,
    IconData? iconData,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;
    final iconColor = isSelected ? AppColor.blueColor : AppColor.grayLightColor;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Icon(iconData, size: 24, color: iconColor)
            else if (icon != null)
              Image.asset(
                icon,
                width: 24,
                height: 24,
                color: iconColor,
                colorBlendMode: BlendMode.srcIn,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 12,
                color: isSelected
                    ? AppColor.blueColor
                    : AppColor.grayLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

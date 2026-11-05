import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/my_provider.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool darkModeEnabled = false;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<MyProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: user?.photoURL != null
                        ? Image.network(
                            user!.photoURL!,
                            height: 116,
                            width: 116,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(AppImage.route, height: 116, width: 116),
                  ),
                  SizedBox(height: 18),
                  Text(
                    user?.displayName ?? userProvider.userModel?.name ?? "",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: provider.themeMode == ThemeMode.dark
                          ? provider.colors.primaryColor()
                          : AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? userProvider.userModel?.email ?? "",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: provider.themeMode == ThemeMode.dark
                          ? provider.colors.primaryColor()
                          : AppColor.grayColor,
                    ),
                  ),
                  SizedBox(height: 28),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeProfile
                              : AppColor.whiteColor,

                          border: provider.themeMode == ThemeMode.dark
                              ? Border.all(
                                  color: AppColor.blueColor,
                                  width: 0.5,
                                )
                              : null,
                        ),

                        child: Row(
                          children: [
                            Text(
                              "dark_mode".tr(),
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                    fontSize: 16,
                                  ),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 15,
                              child: Switch(
                                value: provider.themeMode == ThemeMode.dark,
                                onChanged: (value) {
                                  provider.changeTheme(
                                    value ? ThemeMode.dark : ThemeMode.light,
                                  );
                                },
                                activeThumbColor: AppColor.darkmodeblue,
                                inactiveTrackColor:
                                    AppColor.grayLightColorSwitch,
                                inactiveThumbColor: Colors.white,
                                trackOutlineColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeProfile
                              : AppColor.whiteColor,

                          border: provider.themeMode == ThemeMode.dark
                              ? Border.all(
                                  color: AppColor.blueColor,
                                  width: 0.5,
                                )
                              : null,
                        ),

                        child: Row(
                          children: [
                            Text(
                              "language".tr(),
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                    fontSize: 16,
                                  ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteApp.languageScreen,
                                );
                              },
                              child: Icon(
                                Icons.navigate_next_sharp,
                                size: 25,
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.blueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeProfile
                              : AppColor.whiteColor,

                          border: provider.themeMode == ThemeMode.dark
                              ? Border.all(
                                  color: AppColor.blueColor,
                                  width: 0.5,
                                )
                              : null,
                        ),

                        child: Row(
                          children: [
                            Text(
                              "logout".tr(),
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 16,
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                  ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteApp.logIn,
                                  (route) => false,
                                );
                              },
                              child: Image.asset(AppImage.logout),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

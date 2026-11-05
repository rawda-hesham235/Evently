import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/my_provider.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/core/text/app_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isPasswordVisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<MyProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          AppImage.evently,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "login_title".tr(),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: provider.colors.primaryColor(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: TextField(
                    controller: emailController,
                    style: GoogleFonts.poppins(
                      color: provider.themeMode == ThemeMode.dark
                          ? AppColor.whiteColor
                          : AppColor.black,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "enter_email".tr(),

                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColor.grayLightColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,

                    decoration: InputDecoration(
                      hintText: "enter_password".tr(),

                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: AppColor.grayLightColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? Icon(Icons.remove_red_eye)
                            : Image.asset(AppImage.eyeSlash),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteApp.forgetPassword);
                        },
                        child: Text(
                          "forget_password".tr(),
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                decoration: TextDecoration.underline,
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : null,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseFunction.logIn(
                              emailController.text,
                              passwordController.text,
                              () {
                                if (!context.mounted) return;
                                userProvider.intiUser();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteApp.buttomTab,
                                  (_) => false,
                                );
                              },
                              (message) {
                                Fluttertoast.showToast(
                                  msg: message,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0,
                                );
                              },
                            );
                          },

                          child: Text(
                            "login".tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "no_account".tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.colors.primaryColor(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, RouteApp.signUp);
                      },
                      child: Text(
                        "signup".tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.blueColor,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 10,
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.darkmodeblue
                            : AppColor.beigeColor,
                      ),
                    ),
                    Text(
                      "or".tr(),
                      style: TextStyle(
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.darkmodeblue
                            : null,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 10,
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.darkmodeblue
                            : AppColor.beigeColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseFunction.signInWithGoogle(
                              () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteApp.buttomTab,
                                  (_) => false,
                                );
                              },
                              (description) {
                                Fluttertoast.showToast(
                                  msg: description,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0,
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.whiteColor,
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImage.google,
                                height: 24,
                                width: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "login_google".tr(),
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(
                                      color:
                                          provider.themeMode == ThemeMode.dark
                                          ? AppColor.darkmodeblue
                                          : AppColor.blueColor,
                                      fontSize: 18,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

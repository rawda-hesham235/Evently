import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/core/text/app_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordVisible = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Padding(
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
                ),
                Text(
                  "signup_title".tr(),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: provider.colors.primaryColor(),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: provider.themeMode == ThemeMode.dark
                          ? AppColor.darkmode
                          : AppColor.whiteColor,
                      hintText: "enter_name".tr(),
                      hintStyle: Theme.of(context).textTheme.labelSmall!
                          .copyWith(color: provider.colors.greyColor()),
                      prefixIcon: Image.asset(AppImage.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "enter_email".tr(),
                      prefixIcon: const Icon(Icons.email_outlined),
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
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(Icons.remove_red_eye)
                            : Image.asset(AppImage.eyeSlash),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 8,
                  ),
                  child: TextField(
                    controller: rePasswordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "confirm_password".tr(),
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(Icons.remove_red_eye)
                            : Image.asset(AppImage.eyeSlash),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (passwordController.text !=
                                rePasswordController.text) {
                              Fluttertoast.showToast(
                                msg: "password no matched",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              return;
                            }
                            FirebaseFunction.registerUser(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteApp.logIn,
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
                            "signup".tr(),
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
                      "already_have_account".tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.colors.greyColor(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, RouteApp.logIn);
                      },
                      child: Text(
                        "login".tr(),
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
                                "signup_google".tr(),
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

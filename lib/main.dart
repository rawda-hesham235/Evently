import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/my_theme_app.dart';
import 'package:evently/core/provider/my_provider.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/feature/Home/Tabs/favoriet_screen.dart';
import 'package:evently/feature/Home/Tabs/home_screen.dart';
import 'package:evently/feature/Home/Tabs/profile.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/feature/Home/buttom_tab.dart';
import 'package:evently/feature/Home/widgets/add_event.dart';
import 'package:evently/feature/Home/widgets/language_screen.dart';
import 'package:evently/feature/Login/forget_password.dart';
import 'package:evently/feature/Login/log_in.dart';
import 'package:evently/feature/Login/sign_up.dart';
import 'package:evently/feature/onbording/introdaction_screen.dart';
import 'package:evently/feature/onbording/onbording_screens.dart';
import 'package:evently/feature/onbording/splash_screen.dart';
import 'package:evently/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '473380415536-10h1gufbobeo2gsnb7unpdi6mglbq6ac.apps.googleusercontent.com',
  );
  final prefs = await SharedPreferences.getInstance();

  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  String initialRoute;

  if (isFirstTime) {
    initialRoute = RouteApp.onbordingSceen;
  } else if (FirebaseAuth.instance.currentUser != null) {
    initialRoute = RouteApp.buttomTab;
  } else {
    initialRoute = RouteApp.logIn;
  }
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => MyProvider()),
        ],

        child: MyAPP(initialRoute: initialRoute),
      ),
    ),
  );
}

class MyAPP extends StatelessWidget {
  final String initialRoute;

  const MyAPP({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyThemeApp.lightColor,
      darkTheme: MyThemeApp.darkColor,
      themeMode: provider.themeMode,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(nextRoute: initialRoute),
      routes: {
        RouteApp.onbordingSceen: (context) => OnbordingScreens(),
        RouteApp.homeScreen: (context) => HomeScreen(),
        RouteApp.introdactionScreen: (context) => IntrodactionScreen(),
        RouteApp.logIn: (context) => LogIn(),
        RouteApp.signUp: (context) => SignUp(),
        RouteApp.forgetPassword: (context) => ForgetPassword(),
        RouteApp.buttomTab: (context) => ButtomTab(),
        RouteApp.favorietScreen: (context) => FavorietScreen(),
        RouteApp.addEvent: (context) => AddEvent(),
        RouteApp.profile: (context) => Profile(),
        RouteApp.languageScreen: (context) => LanguageScreen(),
      },
    );
  }
}

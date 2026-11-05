import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/feature/Home/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavorietScreen extends StatefulWidget {
  const FavorietScreen({super.key});

  @override
  State<FavorietScreen> createState() => _FavorietScreenState();
}

class _FavorietScreenState extends State<FavorietScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Container(
      color: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value.trim().toLowerCase();
                  });
                },
                style: GoogleFonts.poppins(
                  color: provider.themeMode == ThemeMode.dark
                      ? AppColor.whiteColor
                      : AppColor.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "search_for_event".tr(),
                  suffixIcon: Icon(
                    Icons.search,
                    color: provider.themeMode == ThemeMode.dark
                        ? AppColor.darkmodeblue
                        : AppColor.blueColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Cards(
                    selectedCategoryId: CategoryModel.all.id,
                    favoritesOnly: true,
                    searchText: searchText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

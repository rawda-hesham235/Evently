import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryEvent {
  final CategoryModel categories;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryEvent({
    required this.categories,
    required this.isSelected,
    required this.onTap,
  });

  Widget categoryButton(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (provider.themeMode == ThemeMode.dark
                    ? AppColor.darkmodeblue
                    : AppColor.blueColor)
              : (provider.themeMode == ThemeMode.dark
                    ? AppColor.darkmode
                    : AppColor.whiteColor),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: provider.themeMode == ThemeMode.dark
                ? AppColor.darkmodeblue
                : AppColor.whiteColor,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categories.icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : provider.themeMode == ThemeMode.dark
                  ? AppColor.darkmodeblue
                  : AppColor.blueColor,
            ),

            const SizedBox(width: 8),
            Text(
              categories.nameKey.tr(),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : provider.themeMode == ThemeMode.dark
                    ? AppColor.whiteColor
                    : AppColor.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

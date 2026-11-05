import 'package:evently/core/image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryModel {
  final String id;
  final String nameKey;
  final IconData icon;
  final String imageLight;
  final String imageDark;

  const CategoryModel({
    required this.id,
    required this.icon,
    this.imageLight = '',
    this.imageDark = '',
    required this.nameKey,
  });

  static CategoryModel fromId(String? id) {
    return categories.firstWhere((c) => c.id == id, orElse: () => sport);
  }

  static CategoryModel? tryFromId(String? id) {
    for (final c in filters) {
      if (c.id == id) return c;
    }
    return null;
  }

  static const CategoryModel all = CategoryModel(
    id: "all",
    icon: Icons.grid_view,
    imageDark: AppImage.all,
    imageLight: AppImage.all,
    nameKey: "all",
  );

  static const CategoryModel sport = CategoryModel(
    id: "sport",
    icon: Icons.directions_bike,
    imageLight: AppImage.sport,
    imageDark: AppImage.sportDark,
    nameKey: "sport",
  );

  static const CategoryModel birthday = CategoryModel(
    id: "birthday",
    icon: Icons.cake,
    imageLight: AppImage.birthday,
    imageDark: AppImage.birthdayDark,
    nameKey: "birthday",
  );
  static const CategoryModel meeting = CategoryModel(
    id: "meeting",
    icon: Icons.laptop_mac,
    imageLight: AppImage.meeting,
    imageDark: AppImage.meetingDark,
    nameKey: "meeting",
  );
  static const CategoryModel bookClub = CategoryModel(
    id: "bookClub",
    icon: Icons.menu_book_rounded,
    imageLight: AppImage.bookClub,
    imageDark: AppImage.bookClubDark,
    nameKey: "bookClub",
  );
  static const CategoryModel exhibition = CategoryModel(
    id: "exhibition",
    icon: Icons.color_lens_outlined,
    imageLight: AppImage.exhibition,
    imageDark: AppImage.exhibitionDark,
    nameKey: "exhibition",
  );

  static const List<CategoryModel> categories = [
    sport,
    birthday,
    bookClub,
    exhibition,
    meeting,
  ];

  static const List<CategoryModel> filters = [all, ...categories];
}

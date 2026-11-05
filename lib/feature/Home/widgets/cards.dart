import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/model/add_event_model.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/feature/Home/widgets/event_detailes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cards extends StatefulWidget {
  final String selectedCategoryId;
  final bool favoritesOnly;
  final String searchText;
  const Cards({
    super.key,
    required this.selectedCategoryId,
    this.favoritesOnly = false,
    this.searchText = "",
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Set<String> favoriteIndexes = {};
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    provider.themeMode == ThemeMode.dark
        ? AppImage.categoryImageDark
        : AppImage.categoryImageLight;
    return StreamBuilder<QuerySnapshot<AddEventModel>>(
      stream: FirebaseFunction.getEvent(widget.selectedCategoryId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('SomeThing Error'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.blueColor),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No events found',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: provider.themeMode == ThemeMode.dark
                    ? AppColor.whiteColor
                    : AppColor.black,
                fontSize: 16,
              ),
            ),
          );
        }

        final filteredDocs = snapshot.data!.docs.where((doc) {
          final event = doc.data();

          final matchesCategory =
              widget.selectedCategoryId == CategoryModel.all.id ||
              event.category.id == widget.selectedCategoryId;

          final matchesFavorite = !widget.favoritesOnly || event.isFavorite;

          final matchesSearch =
              widget.searchText.isEmpty ||
              event.title.toLowerCase().contains(widget.searchText) ||
              event.description.toLowerCase().contains(widget.searchText);

          return matchesCategory && matchesFavorite && matchesSearch;
        }).toList();
        return GridView.builder(
          itemCount: filteredDocs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 193,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final doc = filteredDocs[index];
            final event = doc.data();
            final eventId = doc.id;

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailes(eventId: eventId),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.darkmode
                            : AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : AppColor.whiteColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          provider.themeMode == ThemeMode.dark
                              ? event.category.imageDark
                              : event.category.imageLight,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 66,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.babyblue,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.whiteColor,
                            ),
                          ),

                          child: Center(
                            child: Text(
                              '${event.day} ${event.month}',
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: provider.themeMode == ThemeMode.dark
                                        ? AppColor.darkmodeblue
                                        : AppColor.blueColor,
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 40,
                                width: 66,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmode
                                      : AppColor.babyblue,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: provider.themeMode == ThemeMode.dark
                                        ? AppColor.darkmodeblue
                                        : AppColor.whiteColor,
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      event.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            color:
                                                provider.themeMode ==
                                                    ThemeMode.dark
                                                ? AppColor.whiteColor
                                                : AppColor.black,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final oldValue = event.isFavorite;
                                        final newValue = !oldValue;

                                        setState(() {
                                          event.isFavorite = newValue;
                                        });
                                        await FirebaseFunction.updateEventFavorite(
                                          event,
                                        );
                                      },
                                      child: Icon(
                                        event.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: event.isFavorite
                                            ? (provider.themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColor.darkmodeblue
                                                  : AppColor.blueColor)
                                            : (provider.themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColor.darkmodeblue
                                                  : AppColor.blueColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

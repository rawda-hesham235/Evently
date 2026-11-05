import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/model/add_event_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/feature/Home/widgets/edit_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailes extends StatelessWidget {
  final String eventId;
  EventDetailes({super.key, required this.eventId});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              children: [
                SizedBox(height: 10),
                StreamBuilder<DocumentSnapshot<AddEventModel>>(
                  stream: FirebaseFunction.getEventById(eventId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('some_thing_error'.tr()));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.blueColor,
                        ),
                      );
                    }
                    if (snapshot.data?.data() == null) {
                      return Center(child: Text('Event not found'.tr()));
                    }
                    final event = snapshot.data!.data();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              autofocus: false,
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                  context,
                                  RouteApp.buttomTab,
                                );
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.whiteColor
                                    : AppColor.blueColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(15, 15),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmode
                                    : AppColor.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'event_details'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 18,
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                  ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              autofocus: false,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditEvent(eventId: eventId),
                                  ),
                                );
                              },
                              child: Image.asset(
                                AppImage.edit,
                                height: 20,
                                width: 20,
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.blueColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 10),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmode
                                    : AppColor.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              autofocus: false,
                              onPressed: () async {
                                await FirebaseFunction.deleteEvent(event!);
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.delete,
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.red
                                    : AppColor.red,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(15, 15),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmode
                                    : AppColor.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
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
                            child: provider.themeMode == ThemeMode.dark
                                ? Image.asset(event!.category.imageDark)
                                : Image.asset(event!.category.imageLight),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          event.title,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 18,
                                color: provider.themeMode == ThemeMode.dark
                                    ? provider.colors.primaryColor()
                                    : AppColor.black,
                              ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 373,
                          height: 73,
                          decoration: BoxDecoration(
                            color: provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(16),
                            border: BoxBorder.all(
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.whiteColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmode
                                      : AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: provider.themeMode == ThemeMode.dark
                                        ? AppColor.darkmodeblue
                                        : AppColor.whiteColor,
                                  ),
                                ),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmodeblue
                                      : AppColor.blueColor,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          event.day,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontSize: 16,
                                                color:
                                                    provider.themeMode ==
                                                        ThemeMode.dark
                                                    ? AppColor.darkmodeblue
                                                    : AppColor.black,
                                              ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          event.month,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontSize: 16,
                                                color:
                                                    provider.themeMode ==
                                                        ThemeMode.dark
                                                    ? AppColor.darkmodeblue
                                                    : AppColor.black,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),

                                    Text(
                                      TimeOfDay(
                                        hour: event.hour,
                                        minute: event.minute,
                                      ).format(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            color:
                                                provider.themeMode ==
                                                    ThemeMode.dark
                                                ? provider.colors.greyColor()
                                                : AppColor.grayLightColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "description".tr(),
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 16,
                                color: provider.themeMode == ThemeMode.dark
                                    ? provider.colors.primaryColor()
                                    : AppColor.black,
                              ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 173,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(16),
                            border: BoxBorder.all(
                              color: provider.themeMode == ThemeMode.dark
                                  ? AppColor.darkmodeblue
                                  : AppColor.whiteColor,
                            ),
                          ),
                          child: Text(
                            event.description,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? provider.colors.greyColor()
                                      : AppColor.black,
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

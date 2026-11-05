import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/image/app_image.dart';
import 'package:evently/core/model/add_event_model.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/core/route/route_app.dart';
import 'package:evently/feature/Home/widgets/category_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int selectedIndex = 0;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  final PageController pageController = PageController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Future<void> chooseDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> chooseTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  DateTime get eventDateTime {
    final date = selectedDate!;
    final time = selectedTime!;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.themeMode == ThemeMode.dark
          ? AppColor.darkmode
          : AppColor.babyblue,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Column(
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

                        Expanded(
                          child: Text(
                            "add_event".tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: provider.themeMode == ThemeMode.dark
                                      ? provider.colors.primaryColor()
                                      : AppColor.black,
                                ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          provider.themeMode == ThemeMode.dark
                              ? CategoryModel
                                    .categories[selectedIndex]
                                    .imageDark
                              : CategoryModel
                                    .categories[selectedIndex]
                                    .imageLight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 46,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: CategoryModel.categories.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  final category =
                                      CategoryModel.categories[index];
                                  return CategoryEvent(
                                    categories: category,
                                    isSelected: selectedIndex == index,
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                  ).categoryButton(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'title'.tr(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: provider.themeMode == ThemeMode.dark
                              ? provider.colors.primaryColor()
                              : AppColor.blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,

                      style: GoogleFonts.poppins(
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.whiteColor
                            : AppColor.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(hintText: "enter_title".tr()),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'description'.tr(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: provider.themeMode == ThemeMode.dark
                              ? provider.colors.primaryColor()
                              : AppColor.blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,

                      style: GoogleFonts.poppins(
                        color: provider.themeMode == ThemeMode.dark
                            ? AppColor.whiteColor
                            : AppColor.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "enter_description".tr(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : AppColor.blueColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'eventdate'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                fontSize: 18,
                                color: provider.themeMode == ThemeMode.dark
                                    ? provider.colors.primaryColor()
                                    : AppColor.black,
                              ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            chooseDate();
                          },
                          child: Text(
                            selectedDate == null
                                ? "choose_date".tr()
                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmodeblue
                                      : AppColor.blueColor,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmodeblue
                                      : AppColor.blueColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.darkmodeblue
                              : AppColor.blueColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'event_time'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                fontSize: 18,
                                color: provider.themeMode == ThemeMode.dark
                                    ? provider.colors.primaryColor()
                                    : AppColor.black,
                              ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            chooseTime();
                          },
                          child: Text(
                            selectedTime == null
                                ? "choose_time".tr()
                                : "${selectedTime!.hour}:${selectedTime!.minute}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmodeblue
                                      : AppColor.blueColor,
                                  color: provider.themeMode == ThemeMode.dark
                                      ? AppColor.darkmodeblue
                                      : AppColor.blueColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await addEvent();
                            },

                            child: Text(
                              "add_event".tr(),
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                  ),
                            ),
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
      ),
    );
  }

  Future<void> addEvent() async {
    // 1. التأكد إن كل البيانات مكتوبة
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("fill_all_fields".tr())));
      return;
    }

    // 2. محاولة حفظ الحدث في Firebase
    try {
      debugPrint('Starting to add event...');

      await FirebaseFunction.AddEvent(
        AddEventModel(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          category: CategoryModel.categories[selectedIndex],
          data: eventDateTime,
          isFavorite: false,
          userId: FirebaseAuth.instance.currentUser!.uid,
        ),
      );

      debugPrint('Event added successfully!');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("event_added".tr())));

      // 3. الرجوع بعد نجاح الحفظ فقط
      Navigator.pop(context);
    } catch (e, stackTrace) {
      debugPrint('Error adding event: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("event_add_failed".tr())));
    }
  }
}

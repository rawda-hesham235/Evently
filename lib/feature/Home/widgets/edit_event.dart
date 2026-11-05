import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/colors/app_color.dart';
import 'package:evently/core/firebase_function.dart';
import 'package:evently/core/model/add_event_model.dart';
import 'package:evently/core/model/category_model.dart';
import 'package:evently/core/provider/theme_provider.dart';
import 'package:evently/feature/Home/widgets/category_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final String eventId;
  const EditEvent({super.key, required this.eventId});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descrbtionController = TextEditingController();

  String selectedId = CategoryModel.sport.id;
  CategoryModel? category;
  DateTime? selectedDateValue;
  Future<void> selectedTime(AddEventModel event) async {
    final currentDate = selectedDateValue ?? event.data;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: currentDate.hour,
        minute: currentDate.minute,
      ),
    );
    if (pickedTime != null) {
      final newTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        event.data = newTime;
        selectedDateValue = newTime;
      });
    }
  }

  Future<void> selectedData(AddEventModel event) async {
    final currentDate = selectedDateValue ?? event.data;
    final PickedData = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2017),
      lastDate: DateTime(2030),
    );
    if (PickedData != null) {
      final newDate = DateTime(
        PickedData.year,
        PickedData.month,
        PickedData.day,
        currentDate.hour,
        currentDate.minute,
      );

      setState(() {
        event.data = newDate;
        selectedDateValue = newDate;
      });
      print('Picked Date: $PickedData');
      print('New Date: $newDate');
      print('Event Data: ${event.data}');
    }
  }

  bool isInitialized = false;

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
                Row(
                  children: [
                    ElevatedButton(
                      autofocus: false,
                      onPressed: () {
                        Navigator.pop(context);
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
                        backgroundColor: provider.themeMode == ThemeMode.dark
                            ? AppColor.darkmode
                            : AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'edit_event'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: provider.themeMode == ThemeMode.dark
                              ? provider.colors.primaryColor()
                              : AppColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFunction.getEventById(widget.eventId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('SomeThing Error'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.blueColor,
                        ),
                      );
                    }

                    final event = snapshot.data!.data();
                    if (event == null) {
                      return const Center(child: Text('Event not found'));
                    }

                    if (event != null && !isInitialized) {
                      titleController.text = event.title;
                      descrbtionController.text = event.description;
                      category = event.category;

                      selectedId = category!.id;

                      isInitialized = true;
                    }
                    return Column(
                      children: [
                        SizedBox(height: 10),
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
                                ? Image.asset(category!.imageDark)
                                : Image.asset(category!.imageLight),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 46,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: CategoryModel.categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final categoryItem =
                                    CategoryModel.categories[index];
                                return CategoryEvent(
                                  categories: categoryItem,
                                  isSelected: selectedId == categoryItem.id,
                                  onTap: () {
                                    setState(() {
                                      selectedId = categoryItem.id;
                                      category = categoryItem;
                                    });
                                  },
                                ).categoryButton(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'title'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    fontSize: 18,
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                  ),
                            ),
                          ],
                        ),

                        TextField(
                          controller: titleController,
                          style: TextStyle(
                            color: provider.themeMode == ThemeMode.dark
                                ? provider.colors.greyColor()
                                : AppColor.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.whiteColor,

                            hoverColor: provider.themeMode == ThemeMode.dark
                                ? provider.colors.primaryColor()
                                : AppColor.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.whiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.whiteColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'description'.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    fontSize: 18,
                                    color: provider.themeMode == ThemeMode.dark
                                        ? provider.colors.primaryColor()
                                        : AppColor.black,
                                  ),
                            ),
                          ],
                        ),
                        TextField(
                          controller: descrbtionController,
                          style: TextStyle(
                            color: provider.themeMode == ThemeMode.dark
                                ? provider.colors.greyColor()
                                : AppColor.black,
                          ),
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: provider.themeMode == ThemeMode.dark
                                ? AppColor.darkmode
                                : AppColor.whiteColor,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),

                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.whiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: provider.themeMode == ThemeMode.dark
                                    ? AppColor.darkmodeblue
                                    : AppColor.whiteColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
                                selectedData(event);
                              },
                              child: Text(
                                DateFormat(
                                  'MMM d, yyyy',
                                ).format(selectedDateValue ?? event.data),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          provider.themeMode == ThemeMode.dark
                                          ? AppColor.darkmodeblue
                                          : AppColor.blueColor,
                                      color:
                                          provider.themeMode == ThemeMode.dark
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
                                selectedTime(event);
                              },
                              child: Text(
                                TimeOfDay.fromDateTime(
                                  selectedDateValue ?? event.data,
                                ).format(context),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          provider.themeMode == ThemeMode.dark
                                          ? AppColor.darkmodeblue
                                          : AppColor.blueColor,
                                      color:
                                          provider.themeMode == ThemeMode.dark
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
                                  event.title =
                                      titleController.text.trim().isEmpty
                                      ? event.title
                                      : titleController.text.trim();

                                  event.description =
                                      descrbtionController.text.trim().isEmpty
                                      ? event.description
                                      : descrbtionController.text.trim();
                                  event.category = category ?? event.category;
                                  event.data = selectedDateValue ?? event.data;

                                  await FirebaseFunction.updateEvent(event);
                                  Navigator.pop(context);
                                },

                                child: Text(
                                  "update_event".tr(),
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

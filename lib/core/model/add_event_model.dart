import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/model/category_model.dart';

class AddEventModel {
  String title;
  String id;
  DateTime data;
  bool isFavorite;
  String description;
  String userId;
  CategoryModel category;
  AddEventModel({
    this.id = "",
    required this.title,
    required this.data,
    this.isFavorite = false,
    this.description = '',
    required this.category,
    required this.userId,
  });

  static fromJson(Map<String, dynamic> json) {
    return AddEventModel(
      title: json['title'],
      data: (json['data'] as Timestamp).toDate(),
      description: json['description'],
      id: json['id'],
      isFavorite: json['isFavorite'],
      category: CategoryModel.fromId(json['category']),
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "data": data,
      "description": description,
      "id": id,
      "isFavorite": isFavorite,
      "category": category.id,
      "userId": userId,
    };
  }

  String get day => data.day.toString().padLeft(2, '0');

  String get month => monthNames[data.month - 1];

  int get hour => data.hour;
  int get minute => data.minute;

  static const List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}

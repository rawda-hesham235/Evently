class UserModel {
  String id;
  String name;
  String email;
  String imageUrl;
  String CreatedAt;
  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    this.imageUrl = "",
    required this.CreatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        imageUrl: json['imageUrl'] ?? '',
        CreatedAt: json['CreatedAt'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'CreatedAt': CreatedAt,
    };
  }
}

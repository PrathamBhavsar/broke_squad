class UserModel {
  final String id;
  final String createdAt;
  final String userName;
  final String profileImage;
  final String email;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.userName,
    required this.profileImage,
    required this.email,
  });

  // json to User object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: json['created_at'],
      userName: json['user_name'],
      profileImage: json['profile_image'],
      email: json['email'],
    );
  }

  // User object to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'user_name': userName,
      'profile_image': profileImage,
      'email': email,
    };
  }
}

class Members {
  String id;
  String displayName;
  String amount;
  String profileImage;
  bool isPaid;

  Members(
      {required this.id,required this.displayName, required this.amount, required this.profileImage, required this.isPaid});

  factory Members.fromJson(Map<String, dynamic> json) => Members(
      id: json['id'],
      displayName: json['displayName'],
      amount: json['amount'],
      profileImage: json['profile_image'],
      isPaid: json['isPaid']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'displayName':displayName, 'amount': amount, 'profile_image': profileImage, 'isPaid': isPaid};
}

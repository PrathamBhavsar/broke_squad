class Contact {
  String name;
  String phNo;
  Contact({required this.name, required this.phNo});

  factory Contact.fromJson(Map<String,dynamic> json) {
    return Contact(name: json['name'], phNo: json['ph_no']);
  }

  Map<String,dynamic> toJson() => {
    'name':name,
    'ph_no':phNo,
  };
}
class ActiveUserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String uid;
  final int selectedAddressIndex;
  final List address;

  ActiveUserModel({
    this.name,
    this.phoneNumber,
    this.uid,
    this.address,
    this.email,
    this.selectedAddressIndex,
  });

  factory ActiveUserModel.fromJson(Map<String, dynamic> json) {
    return ActiveUserModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      uid: json['uid'],
      address: json['address'],
      email: json['email'],
      selectedAddressIndex: json['selectedAddressIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'address': address,
      'email': email,
      'selectedAddressIndex': selectedAddressIndex,
    };
  }
}

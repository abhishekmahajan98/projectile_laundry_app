class ShopModel {
  final String name;
  final String phoneNumber;
  final String uid;
  final double latitude;
  final double longitude;

  ShopModel(
      {this.latitude, this.longitude, this.name, this.phoneNumber, this.uid});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      uid: json['uid'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

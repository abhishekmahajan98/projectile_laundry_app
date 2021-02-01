import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectilelaundryapp/models/active_user_model.dart';
import 'package:projectilelaundryapp/models/shop_model.dart';

class FireStoreService {
  final FirebaseFirestore _db;
  final String _userId;

  FireStoreService(this._db, this._userId);

  Future<ActiveUserModel> getUserData() {
    return _db.collection('users').doc(_userId).get().then(
          (value) => ActiveUserModel.fromJson(
            value.data(),
          ),
        );
  }

  Future<void> uploadUserData(Map<String, dynamic> data) async {
    await _db.collection('users').doc(_userId).set(data);
  }

  Future<int> checkUserData() async {
    final userCheck = await _db
        .collection('users')
        .where('uid', isEqualTo: _userId)
        .limit(1)
        .get();
    return userCheck.size;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    //print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }

  Future<ShopModel> getClosestShopInRange(
      {double userLat, double userLong}) async {
    double minDist = 3;
    ShopModel closestShop;
    try {
      QuerySnapshot shops = await _db.collection('shops').get();
      for (var shop in shops.docs) {
        double latitude = shop['latitude'];
        double longitude = shop['longitude'];
        double dist = calculateDistance(userLat, userLong, latitude, longitude);
        if (dist <= 2) {
          ShopModel shopModel = ShopModel.fromJson(shop.data());
          if (dist < minDist) {
            closestShop = shopModel;
            minDist = dist;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return closestShop;
  }
}

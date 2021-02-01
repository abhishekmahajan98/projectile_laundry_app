import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectilelaundryapp/models/active_user_model.dart';

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
}

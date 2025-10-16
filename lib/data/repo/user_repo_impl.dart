import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gorouterdeeplink/domain/model/user_profile_model.dart';
import 'package:gorouterdeeplink/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  @override
  Future<void> createProfile(UserProfileModel profile) async {
    try {
      await _db.collection('users').doc(profile.uid).set(profile.toJson());
      print('hihi');
    } catch (e) {
      print(e);
      print('-------');
    }
  }
}

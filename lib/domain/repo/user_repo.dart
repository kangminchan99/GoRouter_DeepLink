import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/data/repo/user_repo_impl.dart';
import 'package:gorouterdeeplink/domain/model/user_profile_model.dart';

abstract class UserRepository {
  // create profile
  Future<void> createProfile(UserProfileModel profile);

  // get profile
  Future<Map<String, dynamic>?> getProfile(String uid);
}

final userRepo = Provider<UserRepository>((ref) => UserRepoImpl());

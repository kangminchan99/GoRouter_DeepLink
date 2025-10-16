import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/domain/model/user_profile_model.dart';
import 'package:gorouterdeeplink/domain/repo/authentication_repo.dart';
import 'package:gorouterdeeplink/domain/repo/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository.getProfile(
        _authenticationRepository.user!.uid,
      );

      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential, final form) async {
    state = AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? 'Anonymous@undefined.com',
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);

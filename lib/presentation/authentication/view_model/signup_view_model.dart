import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterdeeplink/domain/repo/authentication_repo.dart';
import 'package:gorouterdeeplink/presentation/user/view_model/user_view_model.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = AsyncValue.loading();
    final form = ref.read(signUpForm);
    print('-------');
    print(form);
    final users = ref.read(userProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form['email'],
        form['password'],
      );
      await users.createProfile(userCredential, form);
    });
    if (state.hasError) {
      // showFirebaseErrorSnackBar(context, state.error);
      log(
        'signUp error: ${state.error} (${state.error.runtimeType})',
        stackTrace: state.stackTrace,
      );
    } else {
      context.go('/home');
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);

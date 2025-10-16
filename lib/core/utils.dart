// 파이어베이스 에러 메시지
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showFirebaseErrorSnackBar(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      // action: SnackBarAction(label: "OK", onPressed: () {}),
      content: Text(
        (error as FirebaseException).message ?? 'something went wrong',
      ),
    ),
  );
}

String? isEmailValid(String email) {
  if (email.isEmpty) return null;
  // 이메일 정규 표현식
  final regExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  if (!regExp.hasMatch(email)) {
    return "Email is not valid";
  }
  return null;
}

bool isPasswordValid(String password) {
  return password.isNotEmpty && password.length > 8;
}

void onScaffoldTap(BuildContext context) {
  // 키보드 내리기
  FocusScope.of(context).unfocus();
}

void onClearTap(TextEditingController passwordController) {
  passwordController.clear();
}

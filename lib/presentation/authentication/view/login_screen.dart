import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterdeeplink/core/layout/default_layout.dart';
import 'package:gorouterdeeplink/core/utils.dart';
import 'package:gorouterdeeplink/presentation/authentication/view_model/login_view_model.dart';
import 'package:gorouterdeeplink/presentation/authentication/widgets/form_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formDate = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 폼이 유효한 경우 텍스트 폼 필드의 onSaved에 저장
        _formKey.currentState!.save();
        ref
            .read(loginProvider.notifier)
            .login(formDate['email']!, formDate['password']!, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: GestureDetector(
        onTap: () => onScaffoldTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 28),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please wrtie your email';
                      }
                      return null;
                    },

                    decoration: InputDecoration(hintText: 'Email'),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formDate['email'] = newValue;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Password'),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formDate['password'] = newValue;
                      }
                    },
                  ),
                  SizedBox(height: 28),
                  FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
                    onTap: () => _onSubmitTap(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push('/sign_up');
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}

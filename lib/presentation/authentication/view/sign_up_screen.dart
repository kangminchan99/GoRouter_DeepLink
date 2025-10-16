import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/core/layout/default_layout.dart';
import 'package:gorouterdeeplink/core/utils.dart';
import 'package:gorouterdeeplink/presentation/authentication/view_model/signup_view_model.dart';
import 'package:gorouterdeeplink/presentation/authentication/widgets/form_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _password = '';

  String _email = '';

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_email.isEmpty ||
        isEmailValid(_email) != null ||
        !isPasswordValid(_password)) {
      return;
    }
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      'email': _email,
      'password': _password,
    };

    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBarTitle: 'Sign Up',
      child: SafeArea(
        child: GestureDetector(
          onTap: () => onScaffoldTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.emailAddress,
                  // onSubmit하고 같으나 값을 알 때 사용
                  onEditingComplete: _onSubmit,
                  // 자동 수정 기능 없애기
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: isEmailValid(_email),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                TextField(
                  controller: _passwordController,
                  cursorColor: Theme.of(context).primaryColor,
                  // 비밀번호처럼 보이게
                  obscureText: _obscureText,
                  // onSubmit하고 같으나 값을 알 때 사용
                  onEditingComplete: _onSubmit,
                  // 자동 수정 기능 없애기
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => onClearTap(_passwordController),
                          child: Icon(
                            Icons.delete_forever_sharp,
                            color: Colors.grey.shade500,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 14),
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey.shade500,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your password must have:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 20,
                      color: isPasswordValid(_password)
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    SizedBox(height: 5),
                    Text('8 to 20 characters'),
                  ],
                ),
                SizedBox(height: 10),
                FormButton(
                  onTap: () => _onSubmit(),
                  disabled:
                      _email.isEmpty ||
                      isEmailValid(_email) != null ||
                      !isPasswordValid(_password),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

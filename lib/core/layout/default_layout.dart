import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? appBarTitle;
  final Widget? bottomNavigationBar;
  final Widget? floactingActionButton;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor,
    this.appBarTitle,
    this.bottomNavigationBar,
    this.floactingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: _renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floactingActionButton,
    );
  }

  AppBar? _renderAppBar() {
    if (appBarTitle == null) {
      return null;
    }
    return AppBar(
      title: Text(
        appBarTitle!,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

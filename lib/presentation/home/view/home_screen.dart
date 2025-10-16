import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gorouterdeeplink/core/layout/default_layout.dart';

final tabs = ['Top', 'Users', 'Videos', 'Sounds', 'LIVE', 'Shopping', 'Brands'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: DefaultLayout(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: kIsWeb
                      ? TabAlignment.center
                      : TabAlignment.start,
                  tabs: [for (var tab in tabs) Tab(text: tab)],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      for (var tab in tabs)
                        Center(
                          child: Text(tab, style: TextStyle(fontSize: 28)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

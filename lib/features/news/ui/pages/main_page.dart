import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  static const _pages = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // IndexedStack хранит состояние вкладок (поиск не сбрасывается)
          IndexedStack(index: _index, children: _pages),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: AppBottomNav(
                    currentIndex: _index,
                    onTap: (i) => setState(() => _index = i),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

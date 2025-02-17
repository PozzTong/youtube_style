import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/features.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Menu')),
    const Center(child: Text('Favorites')),
    const Center(child: Text('Profile')),
    const Center(child: Text('Cart')),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: isDarkMode ? Colors.black : Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: _navBarIcons(isDarkMode),
      ),
    );
  }

  List<Widget> _navBarIcons(bool isDarkMode) {
    Color iconColor = isDarkMode ? Colors.white : Colors.black;
    return [
      Icon(Icons.home, color: iconColor),
      Icon(Icons.menu, color: iconColor),
      Icon(Icons.favorite_outline, color: iconColor),
      Icon(Icons.person, color: iconColor),
      Icon(FontAwesomeIcons.cartPlus, color: iconColor),
    ];
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/features.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  bool isMiniPlayVisible;
  BottomNavBar({super.key, required this.isMiniPlayVisible});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late Offset position;
  late bool _isMiniPlayVisible;
  List<Offset> corners = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size size = MediaQuery.of(context).size;
    position =
        Offset(size.width - size.width / 2 - 10, size.height - size.height / 3);
  }

  @override
  void initState() {
    super.initState();
    _isMiniPlayVisible = widget.isMiniPlayVisible;
    print('btn${widget.isMiniPlayVisible}');
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(
      isMiniPlayVisible: true,
    ),
    HeroTags(),
    const Center(child: Text('Favorites')),
    const Center(child: Text('Profile')),
    const AssistiveTouchScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Mini Play Visibility: $_isMiniPlayVisible");
    corners = [
      Offset(10, 40), // Top Left
      Offset(size.width - size.width / 2, 40), // Top Right
      Offset(size.width - size.width / 2 - 10,
          size.height - size.height / 3 - 5), // Bottom Right
      Offset(10, size.height - size.height / 3 - 5), // Bottom Left
    ];
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: Stack(children: [
        _screens[_selectedIndex],
        if (_isMiniPlayVisible)
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: miniPlay(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  position = _getNearestCorner(details.offset);
                });
              },
              child: miniPlay(),
            ),
          ),
      ]),
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

  Offset _getNearestCorner(Offset dragOffset) {
    return corners.reduce((closest, current) =>
        (dragOffset - current).distance < (dragOffset - closest).distance
            ? current
            : closest);
  }

  Widget miniPlay() {
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: 'miniPlay',
      child: Container(
        width: size.width / 2,
        height: size.height / 4,
        color: Colors.yellow,
        child: IconButton(
          onPressed: () {
            setState(() {
              widget.isMiniPlayVisible = false;
            });
            print(widget.isMiniPlayVisible);
          },
          icon: Icon(
            Icons.close,
          ),
        ),
      ),
    );
  }
}

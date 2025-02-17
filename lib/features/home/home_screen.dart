import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _headerHeight = 100.0;
  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        setState(() {
          _headerHeight = 0.0;
          _isScrollingDown = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        setState(() {
          _headerHeight = 100.0;
          _isScrollingDown = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            top: 0,
            left: 0,
            right: 0,
            duration: Duration(seconds: 5),
            curve: Curves.fastOutSlowIn,
            child: Container(
              color: Colors.red,
              height: _headerHeight,
              width: size.width,
            ),
          ),
          Positioned(
            top: _headerHeight,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height - _headerHeight,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("Item $index"));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

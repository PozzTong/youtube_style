import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  bool isMiniPlayVisible;
  HomeScreen({super.key, required this.isMiniPlayVisible});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> texts = [
    'ទាំងអស់',
    "ហ្គេម",
    "តន្រ្តី",
    "ចម្រុះ",
    "ផ្សាយផ្ទាល់",
    "គំនូរជីរចល",
    "ថ្មីៗ",
    "សម្រាប់អ្នក"
  ];
  int selectIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedIndex(int index) {
    double itemWidth = 80.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double scrollOffset =
        (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      scrollOffset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        key: ValueKey(selectIndex),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          isDarkMode
                              ? 'assets/logo/white_logo.png'
                              : "assets/logo/logo.png",
                          width: 70,
                        ),
                        SizedBox(width: size.width / 3),
                        iconBar(
                            tap: () {
                              print(widget.isMiniPlayVisible);
                            },
                            icon: Icons.cast),
                        iconBar(tap: () {}, icon: Icons.notifications),
                        iconBar(tap: () {}, icon: Icons.search)
                      ],
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: texts.length + 2,
                    //     itemBuilder: (context, index) {
                    //       if (index == 0) {
                    //         return icons();
                    //       } else if (index == texts.length + 1) {
                    //         return TextButton(
                    //             onPressed: () {}, child: Text('ផ្ញើរមតិលម្អ'));
                    //       } else {
                    //         return text(texts[index - 1], index - 1);
                    //       }
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        key: ValueKey(selectIndex),
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: texts.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return icons(tap: () {});
                          } else if (index == texts.length + 1) {
                            return TextButton(
                                onPressed: () {}, child: Text('ផ្ញើរមតិលម្អ'));
                          } else {
                            return GestureDetector(
                              key: ValueKey(index),
                              onTap: () {
                                setState(() {
                                  selectIndex = index - 1;
                                });
                                _scrollToSelectedIndex(index - 1);
                                print("Tapped on index: $index");
                              },
                              child: Container(
                                key: ValueKey(index),
                                width: 80,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 4),
                                decoration: BoxDecoration(
                                  color: selectIndex == index - 1
                                      ? Colors.red
                                      : Colors.teal,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    texts[index - 1],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: false,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //slide up
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      VideoPlay(
                                isMiniPlayVisible: widget.isMiniPlayVisible,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin =
                                    Offset(0.0, 1.0); // Start from the bottom
                                const end = Offset.zero; // End at the center
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                          setState(() {
                            widget.isMiniPlayVisible = true;
                          });
                        },
                        child: Container(
                          height: size.height / 3.5,
                          width: size.width,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/profile/babypen.jpg',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "It looks like the scroll offset calculation needs fine-tuning. The issue is likely because the offset calculation is incorrect or the animateTo method is not correctly determining the center position. Let’s refine the logic to ensure the selected item moves to the center.",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    h2(texts: 'Merl Rerng'),
                                    dot(),
                                    h2(texts: '300 views'),
                                    dot(),
                                    h2(texts: '4 hours')
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget h2({required String texts}) => Text(
        texts,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      );

  Container dot() {
    return Container(
      width: 3,
      height: 3,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    );
  }

  Widget iconBar({required Function tap, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(onTap: () => tap(), child: Icon(icon)),
    );
  }

  Widget icons({required Function tap}) {
    return GestureDetector(
      onTap: () => tap(),
      child: Container(
        width: 40,
        margin: EdgeInsets.only(
          top: 4,
          bottom: 2,
          right: 6,
          left: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          FontAwesomeIcons.compass,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget text(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectIndex = index;
        });
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.only(
          top: 4,
          bottom: 2,
          right: 2,
          left: 2,
        ),
        decoration: BoxDecoration(
          color: selectIndex == index ? Colors.red : Colors.teal,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 110; // Fixed height
  @override
  double get maxExtent => 110; // Fixed height

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

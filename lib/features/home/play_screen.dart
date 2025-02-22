import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoPlay extends StatefulWidget {
  bool isMiniPlayVisible;
  VideoPlay({super.key, required this.isMiniPlayVisible});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  bool isHide = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isHide = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isHide = !isHide;
                });
                Future.delayed(Duration(seconds: 5), () {
                  setState(() {
                    isHide = false;
                  });
                });
              },
              child: Hero(
                tag: "miniPlay",
                child: Container(
                    height: size.height / 3,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/image/hungry.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AnimatedOpacity(
                      opacity: isHide ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                ))
                          ],
                        ),
                      ),
                    )),
              ),
            ),
            Positioned(
              // ✅ Positioned should wrap AnimatedOpacity
              top: 5,
              left: 5,
              child: AnimatedOpacity(
                opacity: isHide ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      widget.isMiniPlayVisible = true;
                    });
                    print(widget.isMiniPlayVisible);
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: AnimatedOpacity(
                opacity: isHide ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_down),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cast),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.closed_caption_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.gear),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniPlayerScreen extends StatefulWidget {
  const MiniPlayerScreen({super.key});

  @override
  State<MiniPlayerScreen> createState() => _MiniPlayerScreenState();
}

class _MiniPlayerScreenState extends State<MiniPlayerScreen> {
  static const double _minPlayerHeight = 190.0;
  // ignore: unused_field
  double _playerHeight = 0; // Initial height

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize player to full screen
    if (_playerHeight == 0.0) {
      _playerHeight = MediaQuery.of(context).size.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Text("Main Content Goes Here")), // Your main app content

          Align(
            alignment: Alignment.bottomCenter,
            child: Miniplayer(
              minHeight: _minPlayerHeight,
              maxHeight: MediaQuery.of(context).size.height,
              builder: (height, percentage) {
                return Container(
                  color: Colors.black,
                  child: height > _minPlayerHeight + 50
                      ? _expandedPlayer() // Full view
                      : _miniPlayer(), // Mini view
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Mini Player UI
  Widget _miniPlayer() {
    return GestureDetector(
      onTap: () =>
          setState(() => _playerHeight = MediaQuery.of(context).size.height),
      child: Container(
        height: _minPlayerHeight,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.music_note, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.red,
                child: Text(
                  "Now Playing",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () =>
                    setState(() => _playerHeight = _minPlayerHeight)),
          ],
        ),
      ),
    );
  }

  /// Full Screen Player UI
  Widget _expandedPlayer() {
    return Column(
      children: [
        // AppBar(title: Text("Now Playing")),

        Expanded(
            child: Center(
                child: Text("Full Screen Player UI",
                    style: TextStyle(color: Colors.white)))),
        IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => setState(() => _playerHeight = _minPlayerHeight)),
      ],
    );
  }
}

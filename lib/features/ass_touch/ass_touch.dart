import 'package:flutter/material.dart';

class AssistiveTouchScreen extends StatefulWidget {
  const AssistiveTouchScreen({super.key});

  @override
  State<AssistiveTouchScreen> createState() => _AssistiveTouchScreenState();
}

class _AssistiveTouchScreenState extends State<AssistiveTouchScreen> {
  late Offset position;
  List<Offset> corners = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size size = MediaQuery.of(context).size;
    position = Offset(
        size.width - size.width / 2 - 10, size.height - size.height / 2 + 20);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    corners = [
      Offset(10, 20), // Top Left
      Offset(size.width - size.width / 2, 20), // Top Right
      Offset(size.width - size.width / 2 - 10,
          size.height - size.height / 2 + 20), // Bottom Right
      Offset(10, size.height - size.height / 2 + 20), // Bottom Left
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Assistive Touch Example")),
      body: Stack(
        children: [
          Center(child: Text("Your App Content Here")),
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
        ],
      ),
    );
  }

  Offset _getNearestCorner(Offset dragOffset) {
    return corners.reduce((closest, current) =>
        (dragOffset - current).distance < (dragOffset - closest).distance
            ? current
            : closest);
  }

  Widget miniPlay() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2,
      height: size.height / 4,
      color: Colors.yellow,
    );
  }
}

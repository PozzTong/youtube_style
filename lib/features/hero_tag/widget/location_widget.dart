
import 'package:flutter/material.dart';

import '../model/location.dart';
import '../page/detail_page.dart';
import 'expain_contant_widget.dart';
import 'image_widget.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  const LocationWidget({
    required this.location,
    super.key,
  }) ;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(location: widget.location),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: openDetailPage,
              child: ImageWidget(location: widget.location),
            ),
          ),
        ],
      ),
    );
  }

  void openDetailPage() {
    if (!isExpanded) {
      /// Tap to expand card
      setState(() => isExpanded = true);
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Interval(0, 0.5),
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: DetailPage(location: widget.location, animation: animation),
          );
        },
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}

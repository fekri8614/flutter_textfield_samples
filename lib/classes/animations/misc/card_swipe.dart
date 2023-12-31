import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class CardSwipeDemo extends StatefulWidget {
  const CardSwipeDemo({super.key});
  static String routeName = 'misc/card_swipe';

  @override
  State<CardSwipeDemo> createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeDemo> {
  late List<String> fileNames;

  @override
  void initState() {
    super.initState();
    _resetCards();
  }

  void _resetCards() {
    fileNames = [
      'assets/person_1.jpg',
      'assets/person_2.jpg',
      'assets/person_3.jpg',
      'assets/person_4.jpg',
      'assets/person_5.jpg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Swipe'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ClipRect(
                child: Stack(
                  children: [
                    for (final fileName in fileNames)
                      SwipeableCard(
                        imageAssetName: fileName,
                        onSwiped: () {
                          setState(() {
                            fileNames.remove(fileName);
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Refill'),
              onPressed: () {
                setState(() {
                  _resetCards();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key, required this.imageAssetName});

  final String imageAssetName;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(imageAssetName),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SwipeableCard extends StatefulWidget {
  const SwipeableCard(
      {super.key, required this.imageAssetName, required this.onSwiped});

  final String imageAssetName;
  final VoidCallback onSwiped;

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late double _dragStartX;
  bool _isSwipingLeft = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: GestureDetector(
        onHorizontalDragStart: _dragStart,
        onHorizontalDragUpdate: _dragUpdate,
        onHorizontalDragEnd: _dragEnd,
        child: Card(imageAssetName: widget.imageAssetName),
      ),
    );
  }

  void _dragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
  }

  void _dragUpdate(DragUpdateDetails details) {
    var isSwipingLeft = (details.localPosition.dx - _dragStartX) < 0;
    if (isSwipingLeft != _isSwipingLeft) {
      _isSwipingLeft = isSwipingLeft;
      _updateAnimation(details.localPosition.dx);
    }

    setState(() {
      final size = context.size;

      if (size == null) {
        return;
      }

      _controller.value =
          (details.localPosition.dx - _dragStartX).abs() / size.width;
    });
  }

  void _dragEnd(DragEndDetails details) {
    final size = context.size;

    if (size == null) {
      return;
    }

    var velocity = (details.velocity.pixelsPerSecond.dx / size.width).abs();
    _animate(velocity: velocity);
  }

  void _updateAnimation(double dragPosition) {
    _animation = _controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: _isSwipingLeft ? Offset(-1, 0) : const Offset(1, 0),
    ));
  }

  void _animate({double velocity = 0}) {
    var description =
        const SpringDescription(mass: 50, stiffness: 1, damping: 1);
    var simulation =
        SpringSimulation(description, _controller.value, 1, velocity);
    _controller.animateWith(simulation).then((_) {
      widget.onSwiped();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

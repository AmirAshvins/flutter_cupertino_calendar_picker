import 'package:cupertino_calendar/lib.dart';
import 'package:flutter/material.dart';

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({
    required this.child,
    required this.decoration,
    required this.scaleAlignment,
    required this.onInitialized,
    super.key,
  });

  final Widget child;
  final CalendarContainerDecoration decoration;
  final Alignment scaleAlignment;
  final void Function(AnimationController controller) onInitialized;

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> scale;
  late Animation<double> height;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: calendarAnimationDuration,
      reverseDuration: calendarAnimationReverseDuration,
    );

    scale = CalendarAnimations.scaleAnimation.animate(
      CurvedAnimation(
        parent: _controller,
        curve: calendarAnimationCurve,
      ),
    );
    height = CalendarAnimations.heightAnimation.animate(
      CurvedAnimation(
        parent: _controller,
        curve: calendarAnimationCurve,
      ),
    );

    widget.onInitialized(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Alignment get innerAlignment {
    return switch (widget.scaleAlignment) {
      Alignment.topCenter => Alignment.bottomCenter,
      Alignment.topRight => Alignment.bottomRight,
      Alignment.topLeft => Alignment.bottomLeft,
      Alignment.bottomRight => Alignment.topRight,
      Alignment.bottomLeft => Alignment.topLeft,
      Alignment.bottomCenter => Alignment.topCenter,
      Alignment.center => Alignment.center,
      _ => Alignment.topCenter,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: _controller,
          child: SizedBox(
            width: calendarWidth,
            height: calendarHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: widget.decoration.borderRadius,
                color: widget.decoration.backgroundColor,
                boxShadow: widget.decoration.boxShadow,
              ),
              clipBehavior: Clip.hardEdge,
              child: FittedBox(
                alignment: innerAlignment,
                fit: BoxFit.none,
                child: SizedBox(
                  width: calendarWidth,
                  height: calendarHeight,
                  child: widget.child,
                ),
              ),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: scale.value,
              alignment: widget.scaleAlignment,
              child: Container(
                height: 319.0,
                alignment: widget.scaleAlignment,
                child: SizedBox(
                  height: height.value,
                  child: child,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

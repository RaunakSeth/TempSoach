import 'package:flutter/material.dart';
import 'package:testing/screens/Home_screen/Status_form/EventPath.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTileUI extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventChild;

  const TimeLineTileUI(
      {Key? key,
        required this.isFirst,
        required this.isLast,
        required this.isPast,
        required this.eventChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Color(0xFF11AB2F) : Color(0xFF11AB2F),),
        indicatorStyle: IndicatorStyle(
            width: 40.0,
            color: isPast ? Color(0xFF11AB2F) : Color(0xFF11AB2F),
            iconStyle: IconStyle(
                iconData: Icons.check_circle,
                color:  Color(0xFF11AB2F))),
        endChild: EventPath(
          isPast: isPast,
          childWidget: eventChild,
        ),
      ),
    );
  }
}
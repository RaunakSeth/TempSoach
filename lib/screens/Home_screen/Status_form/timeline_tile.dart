import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Status {
  final String name;
  final bool isCompleted;

  Status({required this.name, required this.isCompleted});
}

class StatusTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Status status;
  final bool isInProgress;

  const StatusTimelineTile({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.status,
    required this.isInProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90, // Adjust the width to fit within the total width of
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          indicator: getIndicatorIcon(),
          drawGap: false, // Ensure no gap is drawn between lines
        ),
        beforeLineStyle: LineStyle(
          thickness: 4,
          color: status.isCompleted ? Colors.green : (isInProgress ? Colors.green : Colors.grey),
        ),
        afterLineStyle: LineStyle(
          thickness: 4,
          color: status.isCompleted ? Colors.green : Colors.grey,
        ),
        endChild: Container(
          constraints: const BoxConstraints(minHeight: 80),
          child: Center(
            child: Text(
              status.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getIndicatorIcon() {
    if (status.isCompleted) {
      return Image.asset('assets/atc.png'); // Path to your completed icon
    } else if (isInProgress) {
      return Image.asset('assets/clock.png'); // Path to your in-progress icon
    } else {
      return Image.asset('assets/tc.png'); // Path to your pending icon
    }
  }
}

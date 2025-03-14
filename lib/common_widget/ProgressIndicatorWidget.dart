import 'package:flutter/material.dart';

import '../resources/color_resources.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const ProgressIndicatorWidget({
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep; // Color up to the current step
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index != 0)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 31,
                  height: 4,
                  color: isActive ? buttonColor1 : Colors.grey, // Active step color
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stepLabels[index],
                  style: TextStyle(
                    color: isActive ? buttonColor1 : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isActive ? buttonColor1 : Colors.grey,
                  child: isActive
                      ? Icon(Icons.done, color: Colors.white)
                      : Text(''), // Show checkmark for completed steps
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

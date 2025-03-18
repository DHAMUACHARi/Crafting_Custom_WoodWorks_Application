import 'package:flutter/material.dart';
import '../resources/color_resources.dart';

class ProgressIndicatorWidget extends StatefulWidget {
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
  _ProgressIndicatorWidgetState createState() => _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant ProgressIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToCurrentStep();
  }

  void _scrollToCurrentStep() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        double position = widget.currentStep * 60.0; // Adjust based on width of each step
        _scrollController.animateTo(
          position,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjust height as needed
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.totalSteps, (index) {
            final isActive = index <= widget.currentStep;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index != 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      width: 21,
                      height: 4,
                      color: isActive ? buttonColor1 : Colors.grey,
                    ),
                  ),
                Column(
                  children: [
                    Text(
                      widget.stepLabels[index],
                      style: TextStyle(
                        color: isActive ? buttonColor1 : Colors.grey,
                        fontSize: 9,
                      ),
                    ),
                    SizedBox(height: 6),
                    CircleAvatar(
                      radius: 19,
                      backgroundColor: isActive ? buttonColor1 : Colors.grey,
                      child: isActive ? Icon(Icons.done, color: Colors.white) : null,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

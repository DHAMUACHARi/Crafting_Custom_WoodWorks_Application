import 'package:flutter/material.dart';

enum CustomDialogType { success, error, warning, info }

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required CustomDialogType type,
  String buttonText = "OK",
  VoidCallback? onButtonPressed, // Custom button action
}) {
  Color dialogColor;
  IconData dialogIcon;

  // Define dialog styles based on type
  switch (type) {
    case CustomDialogType.success:
      dialogColor = Colors.green;
      dialogIcon = Icons.check_circle;
      break;
    case CustomDialogType.error:
      dialogColor = Colors.red;
      dialogIcon = Icons.error;
      break;
    case CustomDialogType.warning:
      dialogColor = Colors.orange;
      dialogIcon = Icons.warning;
      break;
    case CustomDialogType.info:
      dialogColor = Colors.blue;
      dialogIcon = Icons.info;
      break;
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50,bottom: 20,left: 10,right: 10), // Space for the icon
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dialogColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      if (onButtonPressed != null) {
                        onButtonPressed(); // Perform custom action
                      }
                    },
                    child: Text(buttonText, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30, // Adjust position to overlap dialog box
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: dialogColor.withOpacity(0.2),
                  child: Icon(dialogIcon, size: 35, color: dialogColor),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}




// import 'package:flutter/material.dart';
//
// enum CustomDialogType { success, error, warning, info }
//
// void showCustomDialog({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required CustomDialogType type,
//   String okButtonText = "Ok",
//   String cancelButtonText = "Cancel",
//   VoidCallback? onOkPressed,
//   VoidCallback? onCancelPressed,
// }) {
//   Color dialogColor;
//   IconData dialogIcon;
//
//   // Define dialog styles based on type
//   switch (type) {
//     case CustomDialogType.success:
//       dialogColor = Colors.green;
//       dialogIcon = Icons.check_circle;
//       break;
//     case CustomDialogType.error:
//       dialogColor = Colors.red;
//       dialogIcon = Icons.error;
//       break;
//     case CustomDialogType.warning:
//       dialogColor = Colors.orange;
//       dialogIcon = Icons.warning;
//       break;
//     case CustomDialogType.info:
//       dialogColor = Colors.blue;
//       dialogIcon = Icons.info;
//       break;
//   }
//
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.topCenter,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 50), // Space for the icon
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 10),
//                     Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
//                     SizedBox(height: 20),
//
//                     // Action Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // Cancel Button (Red)
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                             if (onCancelPressed != null) {
//                               onCancelPressed();
//                             }
//                           },
//                           child: Text(cancelButtonText, style: TextStyle(color: Colors.white)),
//                         ),
//
//                         // OK Button (Green)
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                             if (onOkPressed != null) {
//                               onOkPressed();
//                             }
//                           },
//                           child: Text(okButtonText, style: TextStyle(color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Floating Icon on Top
//             Positioned(
//               top: -35,
//               child: CircleAvatar(
//                 radius: 35,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: dialogColor.withOpacity(0.2),
//                   child: Icon(dialogIcon, size: 40, color: dialogColor),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';

Widget buildContainerImage(
    BuildContext context, // Added context for MediaQuery
    Color color,
    String title,
    String subtitle,
    String image,
    ) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.06, // Adjusted padding dynamically
      vertical: screenHeight * 0.02,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              child: Image.asset(
                image,
                width: screenWidth * 0.75, // Responsive width
                height: screenHeight * 0.35, // Responsive height
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: screenWidth * 0.75,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.07, // Scalable font size
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: Colors.white.withOpacity(0.9),
              fontStyle: FontStyle.italic,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
      ],
    ),
  );
}

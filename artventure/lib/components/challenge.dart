import 'package:flutter/material.dart';

class Challenge {
  final String name;
  final String info;
  final int points;
  final ImageProvider<Object> imageProvider;

  Challenge({
    required this.name,
    required this.info,
    required this.points,
    ImageProvider<Object>? imageProvider,
  }) : imageProvider =
            imageProvider ?? AssetImage('assets/images/image_not_found.png');

  Widget buildBigCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDiamondPoints(context),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle the action when the user presses the "Done" button
                    },
                    child: Text("Done"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the action when the user presses the "Remove" button
                    },
                    child: Text("Remove"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiamondPoints(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Change the color as needed
      ),
      child: Center(
        child: Text(
          points.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      width: 40,
      height: 40,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final int rating;
  final String reviewDate;
  final String reviewText;

  const ReviewCard({
    Key? key,
    required this.reviewerName,
    required this.rating,
    required this.reviewDate,
    required this.reviewText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd')
        .parse(reviewDate); // Adjust the format as per your date string
    String formattedDate = DateFormat('MMMM d, y').format(parsedDate);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
      child: Stack(clipBehavior: Clip.none, children: [
        Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                        const Spacer(),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  reviewText,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Helpful',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.thumb_up,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          left: -15,
          top: -30,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20,
            backgroundImage: AssetImage(
                'assets/images/avatar1.jpg'), // Replace with your image URL
          ),
        ),
      ]),
    );
  }
}

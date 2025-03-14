import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sahm/Features/details_screen/models/RatingReview_model.dart';

class RatingSummary extends StatelessWidget {
  final List<Review> reviews;

  const RatingSummary({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate overall rating
    double overallRating = reviews.isNotEmpty
        ? reviews.fold(0, (sum, review) => sum + review.ratings) /
            reviews.length
        : 0.0;

    // Calculate total ratings
    int totalRatings = reviews.length;

    // Calculate rating counts for each star level
    List<int> ratingCounts = List.generate(5, (index) {
      int star = 5 - index;
      return reviews.where((review) => review.ratings == star).length;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              overallRating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '$totalRatings ratings',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...List.generate(5, (index) {
          final starCount = 5 - index;
          final ratingCount = ratingCounts[index];
          return _buildRatingBar(starCount, ratingCount, totalRatings);
        }).reversed, // Reversing to start from 5 stars
      ],
    ).animate().fadeIn().scale().move(
                    delay: 20.ms,
                    duration: 600.ms,
                  )
            .animate().fadeIn().scale().move(
                  delay: 20.ms,
                  duration: 600.ms,
            );
  }

  // Individual rating bar for each star level
  Widget _buildRatingBar(int star, int count, int totalRatings) {
    return Row(
      children: [
        // Display stars instead of numbers
        Row(
          children: List.generate(
              star, (index) => Icon(Icons.star, color: Colors.amber, size: 16)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: totalRatings > 0 ? count / totalRatings : 0,
              child: Container(
                height: 8, // Adjust the height of the progress bar
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text('$count'), // Keep the count to the right
      ],
    );
  }
}

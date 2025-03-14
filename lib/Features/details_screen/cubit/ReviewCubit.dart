import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sahm/Features/details_screen/cubit/ReviewState.dart';
import 'package:sahm/Features/details_screen/models/RatingReview_model.dart';
import 'package:sahm/core/constant/constant.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  final String apiUrl = 'https://sahm-backend.onrender.com/api/product';

  // Fetch reviews for a specific product by its ID
  void fetchReviews(String productId, int page) async {
    try {
      emit(ReviewLoading());

      // Construct the API URL with the productId
      final response = await http.get(Uri.parse('$apiUrl/$productId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Log the response to inspect the structure
        log('API Response: $jsonData');

        // Check if 'data' key exists and has reviews
        if (jsonData.containsKey('data')) {
          final data = jsonData['data'];

          // Handle the case where reviews may or may not be present
          if (data.containsKey('reviews') &&
              (data['reviews'] as List).isNotEmpty) {
            List<Review> reviews = (data['reviews'] as List)
                .map((review) => Review.fromJson(review))
                .toList();

            emit(ReviewLoaded(
              reviews: reviews,
              currentPage: page,
              totalPages:
                  1, // Assuming pagination isn't available for reviews, adjust as needed
            ));
          } else {
            // No reviews found
            emit(ReviewEmpty());
          }
        } else {
          emit(ReviewError('No product data found'));
        }
      } else {
        emit(ReviewError(
            'Failed to fetch reviews. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ReviewError('Error: ${e.toString()}'));
    }
  }
   Future<void> postReview({
    required String title,
    required int ratings,
    required String userId,
    required String productId,
  }) async {
    try {
         emit(ReviewLoading());
      // URL for posting a review
      final postUrl = 'https://sahm-backend.onrender.com/api/review';

      // Create the request body
      final Map<String, dynamic> reviewData = {
        'title': title,
        'ratings': ratings,
        'user': userId,
        'product': productId,
      };

      // Send the POST request
      final response = await http.post(
        Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.token}'
        },
        body: json.encode(reviewData),
      );

      // Log the response for debugging
      log('Review POST Response: ${response.body}');
      
      // Handle the response
      if (response.statusCode == 201) {
        
        log('Review posted successfully');
        emit(ReviewPostSuccess());
        
      } else if (response.statusCode == 400) {
        emit(ReviewError('You already created a review before'));
      } else {
        emit(ReviewError(
            'Failed to post review. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ReviewError('Error posting review: ${e.toString()}'));
    }
  }
}

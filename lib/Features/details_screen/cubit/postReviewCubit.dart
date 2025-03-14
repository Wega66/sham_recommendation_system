import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sahm/Features/details_screen/cubit/postReviewState.dart';

class SubmitReviewCubit extends Cubit<SubmitReviewState> {
  SubmitReviewCubit() : super(SubmitReviewInitial());

  // Replace this URL with your actual API endpoint
  final String postReviewUrl = 'https://example.com/api/reviews';

  // Method to submit the review
  Future<void> submitReview(
      int rating, String reviewText, String productId) async {
    emit(SubmitReviewLoading());

    try {
      final response = await http.post(
        Uri.parse(postReviewUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'product_id': productId, // Pass product ID
          'rating': rating,
          'review_text': reviewText,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, emit success
        emit(SubmitReviewSuccess());
      } else {
        // If the server returns an error, emit failure with message
        emit(SubmitReviewFailure('Failed to post review'));
      }
    } catch (error) {
      // Handle any errors that occur during the request
      emit(SubmitReviewFailure(error.toString()));
    }
  }
}

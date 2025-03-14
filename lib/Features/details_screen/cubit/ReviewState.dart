import 'package:sahm/Features/details_screen/models/RatingReview_model.dart';
import 'package:sahm/core/models/product_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewEmpty extends ReviewState {}

class ReviewPostSuccess extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;
  final int currentPage;
  final int totalPages;

  ReviewLoaded(
      {required this.reviews,
      required this.currentPage,
      required this.totalPages});
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError(this.message);
}

abstract class SubmitReviewState {}

class SubmitReviewInitial extends SubmitReviewState {}

class SubmitReviewLoading extends SubmitReviewState {}

class SubmitReviewSuccess extends SubmitReviewState {}

class SubmitReviewFailure extends SubmitReviewState {
  final String error;
  SubmitReviewFailure(this.error);
}

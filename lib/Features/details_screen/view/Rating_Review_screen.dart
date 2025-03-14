import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sahm/Features/details_screen/cubit/ReviewCubit.dart';
import 'package:sahm/Features/details_screen/cubit/ReviewState.dart';
import 'package:sahm/Features/details_screen/widget/ReviewBottomSheet.dart';
import 'package:sahm/Features/details_screen/widget/raeting_summary.dart';
import 'package:sahm/Features/details_screen/widget/review_card.dart';
import 'package:sahm/core/models/product_model.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override 
  
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  initState() {
    super.initState();
    context.read<ReviewCubit>().fetchReviews(widget.product.id, 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is ReviewPostSuccess) {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review posted successfully!')),
              );
              context.read<ReviewCubit>().fetchReviews(widget.product.id, 1);
            } else if (state is ReviewError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              context.read<ReviewCubit>().fetchReviews(widget.product.id, 1);
            }
          },
          child: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return  Center(
                  child: LoadingAnimationWidget.inkDrop(
                    size: 50,
                    color: Colors.green,
                  ),
                );
              } else if (state is ReviewLoaded) {
                return _buildReviewsContent(context, state);
              } else if (state is ReviewError) {
                return Center(child: Text(state.message));
              } else if (state is ReviewEmpty) {
                return const Center(child: Text('No Reviews Available'));
              }
              return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showReviewSheet(context);
        },
        label: const Text(
          'Write a review',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        icon: const Icon(
          Icons.edit,
          size: 12,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildReviewsContent(BuildContext context, ReviewLoaded state) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            'Rating & Reviews',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          RatingSummary(reviews: state.reviews),
          const SizedBox(height: 20),
          Text(
            '${state.reviews.length} reviews',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: state.reviews.length,
              itemBuilder: (context, index) {
                final review = state.reviews[index];
                return ReviewCard(
                  rating: review.ratings,
                  reviewDate: review.createdAt,
                  reviewText: review.title,
                  reviewerName: review.user.name,
                ).animate().fadeIn().scale().move(
                    delay: 20.ms,
                    duration: 600.ms,
                  
            ).animate().fadeIn().scale().move(
                  delay: 20.ms,
                  duration: 600.ms,
                );
                
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[200],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return ReviewBottomSheet(product: widget.product);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/details_screen/cubit/ReviewCubit.dart';
import 'package:sahm/core/constant/constant.dart';
import 'package:sahm/core/models/product_model.dart';

class ReviewBottomSheet extends StatefulWidget {
  final Product product;
  const ReviewBottomSheet({required this.product, Key? key}) : super(key: key);

  @override
  ReviewBottomSheetState createState() => ReviewBottomSheetState();
}

class ReviewBottomSheetState extends State<ReviewBottomSheet> {
  int _rating = 0;
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewCubit = context.read<ReviewCubit>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildReviewForm(context, reviewCubit),
        ],
      ),
    );
  }

  Widget _buildReviewForm(BuildContext context, ReviewCubit reviewCubit) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'What is your rate?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildRatingStars(),
          const SizedBox(height: 20),
          const Text(
            'Please share your opinion about the product',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildReviewTextField(),
          const SizedBox(height: 20),
          _buildSendButton(context, reviewCubit),
        ],
      ),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildReviewTextField() {
    return TextField(
      controller: _reviewController,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Your review',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context, ReviewCubit reviewCubit) {
    return ElevatedButton(
      onPressed: () {
        if (_rating > 0 && _reviewController.text.isNotEmpty) {
          reviewCubit.postReview(
            title: _reviewController.text,
            ratings: _rating,
            userId: '', // Fetch actual user ID
            productId: widget.product.id,
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please provide a rating and review')),
          );
        }
      },
      child: const Text('SEND REVIEW'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }
}

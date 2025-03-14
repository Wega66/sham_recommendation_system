part of 'add_to_cart_cubit.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

final class AddToCartInitial extends AddToCartState {}

final class SuccessAddToCart extends AddToCartState {}

final class LoadingAddToCart extends AddToCartState {}

final class FillAddToCartInitial extends AddToCartState {
  final String errorMasseg;

  const FillAddToCartInitial({required this.errorMasseg});
}

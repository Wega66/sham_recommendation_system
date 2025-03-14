part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError(this.error);
}

class FavoriteSuccess extends FavoriteState {
  final List<Product> favoriteProduct;

  const FavoriteSuccess(this.favoriteProduct);
}

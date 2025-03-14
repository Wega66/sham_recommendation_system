part of 'sahm_cubit.dart';

abstract class SahmState extends Equatable {
  const SahmState();

  @override
  List<Object?> get props => [];
}

class SahmInitial extends SahmState {}

class SahmLoading extends SahmState {}

class SahmError extends SahmState {
  final String error;

  const SahmError(this.error);
}

class SuccessGetProduct extends SahmState {
  final List<Product> products; // قائمة المنتجات
  const SuccessGetProduct(
    this.products,
  );
}

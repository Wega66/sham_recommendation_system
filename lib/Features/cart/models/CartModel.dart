class CartModel {
  final List<CartItemm> cartItems;
final int? totalCartPrice;
  CartModel({
     this.totalCartPrice,
    required this.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      totalCartPrice: json['data']['totalCartPrice'],
      cartItems: (json['data']['cartItems'] as List)
          .map((item) => CartItemm.fromJson(item))
          .toList(),
    );
  }
}

class CartItemm {
  String? product; // Product ID
  int? quantity;
  int? price;
  String? id;
  ProductModel? productDetails; // Add this to store product details

  CartItemm({
    this.product,
    this.quantity,
    this.price,
    this.id,
    this.productDetails,
  });

  factory CartItemm.fromJson(Map<String, dynamic> json) {
    return CartItemm(
      product: json['product'],
      quantity: json['quantity'],
      price: _parseToInt(json['price']),
      id: json['_id'],
      productDetails: null, // Product details will be fetched separately
    );
  }

  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class ProductModel {
  String? id;
  String? title;
  String? description;
  int? price;
  double? priceAfterDiscount;
  String? imageCover;
  double? ratingsAverage;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.priceAfterDiscount,
    this.imageCover,
    this.ratingsAverage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: _parseToInt(json['price']),
      priceAfterDiscount: _parseToDouble(json['priceAfterDiscount']),
      imageCover: json['imageCover'],
      ratingsAverage: _parseToDouble(json['ratingsAverage']),
    );
  }

  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

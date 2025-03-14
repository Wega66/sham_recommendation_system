class CartResponse {
  final String status;
  final int numOfCartItems;
  final CartData data;

  CartResponse({
    required this.status,
    required this.numOfCartItems,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json['status'],
      numOfCartItems: json['numOfCartItems'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final String id;
  final List<CartItem> cartItems;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final double totalCartPrice;

  CartData({
    required this.id,
    required this.cartItems,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.totalCartPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    var items = json['cartItems'] as List;
    List<CartItem> cartItemsList =
        items.map((item) => CartItem.fromJson(item)).toList();

    return CartData(
      id: json['_id'],
      cartItems: cartItemsList,
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
      totalCartPrice: json['totalCartPrice'].toDouble(),
    );
  }
}

class CartItem {
  final String product;
  final int quantity;
  final double price;
  final String id;

  CartItem({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json['product'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      id: json['_id'],
    );
  }
}

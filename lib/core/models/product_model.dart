import 'package:sahm/Features/details_screen/models/RatingReview_model.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final int sold;
  final double price;
  final double priceAfterDiscount;
  final List<String> images;
  final String imageCover;
  final Category category;
  final double ratingsAverage;
  final int ratingsQuantity;
  final bool trending;
  final bool specials;
  final String productLink;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isFavorite;
 List<Review>? reviews; 


  Product({
    this.reviews,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.sold,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.imageCover,
    required this.category,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.trending,
    required this.specials,
    required this.productLink,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
       reviews: json['reviews'] != null
            ? List<Review>.from(
                json['reviews'].map((review) => Review.fromJson(review)))
            : null,
        id: json['_id'] ?? '', // تأكد من أن ID ليس null
        title: json['title'] ?? 'Unknown Product', // تعيين عنوان افتراضي
        description: json['description'] ?? 'No description available.',
        quantity: (json['quantity'] ?? 0) is int
            ? json['quantity']
            : (json['quantity'] ?? 0).toInt(), // تحويل إلى int
        sold: (json['sold'] ?? 0) is int
            ? json['sold']
            : (json['sold'] ?? 0).toInt(), // تحويل إلى int
        price: (json['price'] ?? 0).toDouble(),
        priceAfterDiscount: (json['priceAfterDiscount'] ?? 0).toDouble(),
        images: json['images'] != null && json['images'] is List
            ? List<String>.from(json['images'])
            : [], // معالجة قائمة الصور
        imageCover: json['imageCover'] ?? '',
        category: Category.fromJson(json['category'] ?? {}),
        ratingsAverage: (json['ratingsAverage'] ?? 0.0).toDouble(),
        ratingsQuantity: (json['ratingsQuantity'] ?? 0) is int
            ? json['ratingsQuantity']
            : (json['ratingsQuantity'] ?? 0).toInt(), // تحويل إلى int
        trending: json['trending'] ?? false,
        specials: json['specials'] ?? false,
        productLink: json['productLink'] ?? '',
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(), // معالجة التاريخ
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
      );
    } catch (e) {
      print("Error parsing product: $e");
      return Product(
      
        id: '',
        title: 'Error Product',
        description: '',
        quantity: 0,
        sold: 0,
        price: 0.0,
        priceAfterDiscount: 0.0,
        images: [],
        imageCover: '',
        category: Category(name: 'Unknown'),
        ratingsAverage: 0.0,
        ratingsQuantity: 0,
        trending: false,
        specials: false,
        productLink: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? 'Uncategorized', // تعيين اسم افتراضي في حالة null
    );
  }
}

// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, unrelated_type_equality_checks

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:sahm/core/constant/constant.dart';
import 'package:sahm/core/models/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
//! Get Favorite
  Future getFavoriteProduct() async {
    try {
      emit(FavoriteLoading());

      Dio dio = Dio();

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var url = 'https://sahm-backend.onrender.com/api/wishlist';
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer ${AppStrings.token}",
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final parsed = response.data;

        List<Product> products = (parsed['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList();

        emit(FavoriteSuccess(products));
        return products;
      } else {
        var dataError = response.data["message"];
        response.data["error"]["statusCode"];
        emit(FavoriteError(dataError));
        return [];
      }
    } catch (e) {
      emit(FavoriteError("InterNet"));
    }
  }
//!  Remove Favorite

  Future removeFavorite({required String id}) async {
    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var url = 'https://sahm-backend.onrender.com/api/wishlist/$id';
    var response = await dio.delete(
      url,
      options: Options(
        headers: {
          "Authorization": "Bearer ${AppStrings.token}",
        },
      ),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      var errorMassage = response.data["message"];
      response.data["error"]["statusCode"];
      print(errorMassage);
      return [];
    }
  }

  //! Add Favorite Product
  Future addFavorite({required String id}) async {
    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var url = 'https://sahm-backend.onrender.com/api/wishlist';
    var response = await dio.post(
      url,
      data: {
        "productId": id,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer ${AppStrings.token}",
        },
      ),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      response.data["message"];
      response.data["error"]["statusCode"];
      return [];
    }
  }
}

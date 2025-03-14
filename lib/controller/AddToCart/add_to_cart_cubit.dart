// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:sahm/core/constant/constant.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  addToCart({required String id}) async {
    try {
      emit(LoadingAddToCart());
      var dio = Dio();

      // إعداد الـ Dio لتجاوز مشاكل الشهادة
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var url = 'https://sahm-backend.onrender.com/api/cart';

      // تأكد من أنك تستخدم الـ ID الصحيح
      var response = await dio.post(
        url,
        data: {
          "productId": id, // استخدم id الممرر
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${AppStrings.token}",
          },
        ),
      );

      print('Response Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        emit(SuccessAddToCart());
        final parsed = response.data;
        print('Response Data: $parsed');
        return parsed;
      } else {
        print('Error: ${response.data}');
        emit(const FillAddToCartInitial(errorMasseg: "Error"));
        return [];
      }
    } catch (e) {
      print('************error************');
      print(e.toString());
      emit(const FillAddToCartInitial(errorMasseg: 'No EnterNet'));
      return [];
    }
  }
}

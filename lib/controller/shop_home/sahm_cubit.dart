// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:sahm/core/models/product_model.dart';

part 'sahm_state.dart';

class SahmCubit extends Cubit<SahmState> {
  SahmCubit() : super(SahmInitial());
  //! get list of product

  Future<List<Product>> getProduct() async {
    try {
      emit(SahmLoading());

      var dio = Dio();

      // تخطي التحقق من الشهادات SSL
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var url = 'https://sahm-backend.onrender.com/api/product';

      var response = await dio.get(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final parsed = response.data; // في Dio مش محتاج تعمل decode

        List<Product> products = (parsed['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList();

        emit(SuccessGetProduct(products));
        return products;
      } else {
        emit(SahmError('فشل في جلب المنتجات'));
        return [];
      }
    } catch (e) {
      print('£££££££££££££££error££££££££££££££ ');
      emit(SahmError('InterNet'));
      print(e.toString());
      return [];
    }
  }
}

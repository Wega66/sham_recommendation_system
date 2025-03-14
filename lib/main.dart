import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sahm/Features/details_screen/cubit/ReviewCubit.dart';
import 'package:sahm/controller/Favorite/favorite_cubit.dart';
import 'package:sahm/controller/shop_home/sahm_cubit.dart';
import 'package:sahm/core/constant/constant.dart';
import 'package:sahm/core/shared/shared_prefrances.dart';
import 'package:sahm/core/themes/app_bar_theme.dart';
import 'package:sahm/Features/botton_nav/home_nave.dart';
import 'Features/splashScreen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the saved token from SharedPreferences
  AppStrings.token = await SharedPreferencesHelper.getString("token");
  AppStrings.userId=await SharedPreferencesHelper.getString("userId");
  AppStrings.userName=await SharedPreferencesHelper.getString("userName");
  log(AppStrings.token.toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ReviewCubit()),
            BlocProvider<SahmCubit>(
              create: (context) => SahmCubit(),
            ),
            BlocProvider<FavoriteCubit>(
              create: (context) => FavoriteCubit(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: TAppBarTheme.lightAppBarTheme,
              useMaterial3: false,
            ),
            home: AppStrings.token?.isNotEmpty ?? false
                ? const HomeNave()
                : const SplashOneScreen(),
          ),
        );
      },
    );
  }
}

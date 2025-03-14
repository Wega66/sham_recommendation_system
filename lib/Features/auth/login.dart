// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sahm/core/shared/shared_prefrances.dart';

import 'package:sahm/Features/auth/forget_password.dart';

import 'package:sahm/Features/auth/sign_up.dart';
import 'package:sahm/Features/botton_nav/home_nave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = false;

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 106, 0, 0),
            child: Text(
              "Login",
              style: GoogleFonts.tajawal(
                  textStyle: const TextStyle(
                      fontSize: 34, fontWeight: FontWeight.w700)),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: Container(
                    height: 64,
                    width: 343,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        //border: BorderRadius.circular(4),
                        labelText: "Email",
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        suffixIcon: const Icon(
                          Icons.check,
                          color: Color.fromRGBO(42, 169, 82, 1),
                        ),
                        labelStyle: GoogleFonts.tajawal(
                            textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(155, 155, 155, 1))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: Container(
                    height: 64,
                    width: 343,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        labelText: "Password",
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        suffixIcon:
                            //  const Icon(
                            //   Icons.close,
                            //   color: Color.fromRGBO(240, 31, 14, 1),
                            // ),
                            IconButton(
                          onPressed: () {
                            setState(() {
                              //! Toggle visibility of the password
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: _obscureText
                              ? const Icon(
                                  Icons.close,
                                  color: Color.fromRGBO(240, 31, 14, 1),
                                )
                              : const Icon(
                                  Icons.check,
                                ),
                        ),
                        labelStyle: GoogleFonts.tajawal(
                            textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(155, 155, 155, 1))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetScreen()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text(
                        "Forgot your password?",
                        style: GoogleFonts.tajawal(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(252, 15, 15, 1))),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(108, 5, 0, 0),
              child: Text(
                "don't have an account?",
                style: GoogleFonts.tajawal(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(16, 16, 16, 1))),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Container(
                height: 48,
                width: 343,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 150, 83, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                    onPressed: () {
                      _signIn();
                    },
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.tajawal(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 255, 255, 1))),
                    ))),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(105, 100, 0, 0),
              child: Text(
                "Or login with social account",
                style: GoogleFonts.tajawal(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(34, 34, 34, 1))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 57),
            child: Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(88, 12, 0, 0),
                    child: Container(
                      height: 64,
                      width: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 8,
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 1))
                          ]),
                      child: Image.asset(
                        'assets/images/google.png',
                        scale: 2,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Container(
                      height: 64,
                      width: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 8,
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 1))
                          ]),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        scale: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  //! the Function Sing In => Api
  _signIn() async {
    var body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
    });
    http.Response response = await http.post(
      Uri.parse('https://sahm-backend.onrender.com/api/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('Success');
      var getToken = json.decode(response.body);
      String token = getToken["token"];
      String userId=getToken['_id'];
      String userName=getToken['name'];
      SharedPreferencesHelper.saveString("userName", userName);
    SharedPreferencesHelper.saveString("userId", userId);
      SharedPreferencesHelper.saveString("token", token);

      print(token);
      emailController.clear();
      passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeNave()),
      );
    } else {
      print('#############Error#############');

      // var errorResponse = json.decode(response.body);
      // var errorMessage = errorResponse["error"];
      // print(errorMessage);
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect email or password"),
      ));
    }
  }
}

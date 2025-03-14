import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sahm/Features/auth/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
//! SignUp Function
  signUpFunction() async {
    var response = await http.post(
      Uri.parse('https://sahm-backend.onrender.com/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'passwordConfirm': passwordController.text,
      }),
    );
    if (response.statusCode == 201) {
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      passwordController.clear();
      print(response.statusCode);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    } else {
      print('Failed to sign up: ${response.reasonPhrase}');
      var resData = json.decode(response.body);
      var errorMessage = resData["errors"][0]["msg"];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage.toString()),
      ));
    }
  }

  bool _obscureText = false;

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        //border: BorderRadius.circular(4),
                        labelText: "Name",
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
                        labelText: "Phone Or Email",

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
                      obscureText: !_obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        labelText: "Password",
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        suffixIcon: const Icon(
                          Icons.close,
                          color: Color.fromRGBO(240, 31, 14, 1),
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        labelText: 'Confirm Password',
                        prefixStyle: GoogleFonts.tajawal(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        suffixIcon: const Icon(
                          Icons.close,
                          color: Color.fromRGBO(240, 31, 14, 1),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 11, 0, 0),
            child: Container(
                height: 48,
                width: 343,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 150, 83, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                    onPressed: () {
                      signUpFunction();
                    },
                    child: Text(
                      "SignUp",
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
}

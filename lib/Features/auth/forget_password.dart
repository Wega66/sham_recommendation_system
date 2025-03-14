// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sahm/Features/auth/add_new_passward.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

final GlobalKey<FormState> gkey = GlobalKey<FormState>();

final TextEditingController gControl = TextEditingController();
final TextEditingController controllers = TextEditingController();

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    // final currentWidth = MediaQuery.of(context).size.width-36.4285;
    // final currenheight = MediaQuery.of(context).size.height+128.571429;
    //return const Placeholder();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 249, 249, 1),
          elevation: 0,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: const Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(34, 34, 34, 1),
                size: 24,
              ),
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //     builder:(context)=> LoginScreenTest()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: gkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 18, 0, 0),
                  child: Text(
                    "Forgot password",
                    style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(34, 34, 34, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(82, 58, 0, 0),
                  child: Text(
                    "Please, enter your  Phone Or Email",
                    style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(34, 34, 34, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 22, 0, 0),
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
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: gControl,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(240, 31, 14, 1), width: 1),
                        ),
                        border: InputBorder.none,
                        labelText: "Phone Or Email",
                        prefixStyle: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        suffixIcon: Icon(
                          Icons.close,
                          color: Color.fromRGBO(240, 31, 14, 1),
                          size: 19,
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        labelStyle: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(155, 155, 155, 1))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 37, 0, 0),
                  child: Container(
                      height: 48,
                      width: 343,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(33, 150, 83, 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                            _SendEmail();
                          },
                          child: Text(
                            "SEND",
                            style: GoogleFonts.tajawal(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(121, 111, 0, 0),
                  child: Text(
                    "Please, enter OPT code",
                    style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(34, 34, 34, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 11, 0, 0),
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
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllers,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "OTP",
                        suffixIcon: Icon(
                          Icons.check,
                          color: Color.fromRGBO(42, 169, 82, 1),
                          size: 19,
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        hintStyle: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(155, 155, 155, 1))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 37, 0, 0),
                  child: Container(
                      height: 48,
                      width: 343,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(33, 150, 83, 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                            _sendCode();
                            //   if(success==true)
                            //   Navigator.push(context, MaterialPageRoute(
                            //       builder:(context)=> AndroidAuthPage()),
                            //       );
                          },
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.tajawal(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                          ))),
                ),
              ],
            ),
          ),
        ));
  }

  //! Send Email for Reset Password
  _SendEmail() async {
    var responseBody = json.encode({"email": gControl.text});
    var url =
        Uri.parse('https://sahm-backend.onrender.com/api/auth/forgotPassword');
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: responseBody,
    );

    if (response.statusCode == 200) {
      var responseDecode = json.decode(response.body);
      var status = responseDecode["message"];
      print(status);
      print(responseDecode["status"]);
      const ScaffoldMessenger(
        child: SnackBar(
          content: Text('Success'),
        ),
      );
    } else {
      var responseDecode = json.decode(response.body);
      // var errorMessage = responseDecode["errors"][0]["msg"];
      var errorMessage = responseDecode["message"];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage.toString()),
      ));
      print(errorMessage);
      print(response.statusCode);
    }
  }

  //! Send Code for Phone Verification
  _sendCode() async {
    var responseBody = json.encode({"resetCode": controllers.text});
    var url =
        Uri.parse('https://sahm-backend.onrender.com/api/auth/verifyResetCode');
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: responseBody,
    );

    if (response.statusCode == 200) {
      var responseDecode = json.decode(response.body);
      var status = responseDecode["message"];
      print(status);
      print(responseDecode["status"]);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => AddNewPassword()),
      );
      gControl.clear();
      controllers.clear();
    } else {
      var responseDecode = json.decode(response.body);
      var errorMessage = responseDecode["message"];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage.toString()),
      ));
      print(errorMessage);
      print(response.statusCode);
    }
  }
}

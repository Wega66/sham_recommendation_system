// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sahm/Features/auth/login.dart';

class AddNewPassword extends StatefulWidget {
  const AddNewPassword({super.key});

  @override
  State<AddNewPassword> createState() => _AddNewPasswordState();
}

class _AddNewPasswordState extends State<AddNewPassword> {
  final GlobalKey<FormState> gkey = GlobalKey<FormState>();
  final TextEditingController gmailControl = TextEditingController();
  final TextEditingController passControl = TextEditingController();
  bool isVisibility2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: gkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                controller: gmailControl,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(240, 31, 14, 1), width: 1),
                  ),
                  border: InputBorder.none,
                  labelText: "Phone Or Email",
                  prefixStyle: GoogleFonts.tajawal(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                controller: passControl,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(240, 31, 14, 1), width: 1),
                  ),
                  border: InputBorder.none,
                  labelText: "New Password",
                  prefixStyle: GoogleFonts.tajawal(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          //! Button Sign in
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
                      _addNewPassword();
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
        ],
      ),
    ));
  } //! Send Code for Phone Verification

  // ignore: unused_element
  _addNewPassword() async {
    var responseBody = json.encode({
      "email": gmailControl.text,
      "newPassword": passControl.text,
    });
    var url =
        Uri.parse('https://sahm-backend.onrender.com/api/auth/resetPassword');
    http.Response response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: responseBody,
    );

    if (response.statusCode == 200) {
      var responseDecode = json.decode(response.body);
      var status = responseDecode["message"];
      print(status);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success'),
        ),
      );

      gmailControl.clear();
      passControl.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
      );
    } else {
      var responseDecode = json.decode(response.body);
      var errorMessage = responseDecode["message"];
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage.toString()),
      ));
    }
  }
}

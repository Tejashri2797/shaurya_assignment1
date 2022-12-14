import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SqfliteDatabase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool password = false;
  SqfLiteDatabase obj = SqfLiteDatabase();



  @override
  void initState() {
     obj.createDB();
     Timer(const Duration(seconds: 2),(){
       obj.selectData();
       setState(() {

       });
     });
     // SqfLiteDatabase.data;

     super.initState();
  }


  void clearInputFields(){
    if(formkey.currentState!.validate()){
      txtEmail.clear();
      txtPass.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.tealAccent[100],
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(children: [
                  Container(
                      height: 728,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFF006A75)),

                  ),
                  Positioned(
                    top: 245,
                    child: Container(
                      margin: EdgeInsets.only(right: 30),
                      height: 483,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: Color(0xFFD1D1D1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 110, left: 30, right: 30, bottom: 110),
                        child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    bool emailRegx = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(txtEmail.text);
                                    return (value!.isEmpty)
                                        ? 'Please Enter Email'
                                        : (!emailRegx)
                                            ? 'Please Enter Valid Email'
                                            : null;
                                  },
                                  controller: txtEmail,
                                  decoration: InputDecoration(
                                      hintText: "Email ",
                                      prefixIcon: const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                            image: AssetImage('Assets/mail.png')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                TextFormField(
                                  obscureText: password,
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    bool passwordRegx = RegExp(
                                            '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$')
                                        .hasMatch(txtPass.text);
                                    return (value!.isEmpty)
                                        ? 'Please Enter password'
                                        : (!passwordRegx)
                                            ? 'Please Enter Valid Password'
                                            : null;
                                  },
                                  controller: txtPass,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            password = !password;
                                          });
                                        },
                                        icon: Icon(password
                                            ? Icons.padding
                                            : Icons.lock_rounded),
                                        color: Colors.black26,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 150.0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'registration');
                                      },
                                      child: const Text(
                                        "Forgot Password ",
                                        style: TextStyle(color: Color(0xFF006A75)),
                                      )),
                                ),
                                MaterialButton(
                                  height: 50,
                                  minWidth: 300,
                                  onPressed: () async {
                                    bool match = false;
                                    formkey.currentState?.validate();

                                    SqfLiteDatabase.data.forEach((element) async {
                                      if (element['email'] == txtEmail.text &&
                                          element['password'] == txtPass.text) {
                                        match = true;
                                        Navigator.pushReplacementNamed(context, 'StudentInfoList');
                                        clearInputFields();

                                    }});
                                    if (!match) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Invalid Data')));
                                    }


                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF006A75),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 150,
                    child: Container(
                        //color: const Color(0xFF006A75),
                        //color: const Color(0xFF006A75),
                        height: 250,
                        width: 170,
                        child: const Image(
                          image: AssetImage('Assets/Group 27.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                  Positioned(
                      top: 170,
                      left: 20,
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

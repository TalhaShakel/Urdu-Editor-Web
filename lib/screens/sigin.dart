import 'package:asaan_urdu/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class sign extends StatefulWidget {

  sign({Key? key}) : super(key: key);

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  var nameController = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  createuser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((Value) => Get.to(login()));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 19, 36, 133), Colors.blueAccent]),
        ),
        child: Center(
          child: Container(
            height: size.height * 0.75,
            width: size.height * 0.5,
            child: Card(
              shadowColor: Colors.black,
              elevation: 50,
              margin: EdgeInsets.all(20),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white)),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Dastoor ',
                              style: TextStyle(
                                fontSize: 35,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                // fontSize: 20
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter a valid Name';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter a valid eamil';
                              } else if (!value.contains("@")) {
                                return 'enter a valid eamil';
                              }
                              return null;
                            },
                            controller: email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Your Email',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password";
                              } else if (value.length < 6) {
                                return "Password must be atleast 6 characters long";
                              } else {
                                return null;
                              }
                            },
                            obscureText:  !_passwordVisible,
                            controller: password,
                            decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                             suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     //forgot password screen
                        //   },
                        //   child: const Text(
                        //     'Forgot Password',
                        //   ),
                        // ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo,
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 50, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Register'),
                              onPressed: () {
                                _formKey.currentState?.validate();
                                createuser();
                                print("textFieldsValue");
                                print(nameController.text);
                                print(password.text);
                              },
                            )),
                        // Row(
                        //   children: <Widget>[
                        //     const Text('Does not have account?'),
                        //     TextButton(
                        //       child: const Text(
                        //         'Sign in',
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //       onPressed: () {
                        //         //signup screen
                        //       },
                        //     )
                        //   ],
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        // ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

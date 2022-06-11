import 'package:asaan_urdu/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class forgot extends StatelessWidget {
  var email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  forgot({Key? key}) : super(key: key);
// Future<AuthStatus> resetPassword({required String email}) async {
//     await _auth
//         .sendPasswordResetEmail(email: email)
//         .then((value) => _status = AuthStatus.successful)
//         .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
//     return _status;
//   }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 19, 36, 133), Colors.blueAccent]),
        ),
        child: Center(
          child: Container(
            height: size.height * 0.5,
            width: size.height * 0.5,
            child: Card(
              // color: Colors.blue,
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
                                // fontWeight: FontWeight.w500,
                                // fontSize: 30
                              ),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Reset password',
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
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo,
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 50, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Reset password'),
                              onPressed: () async {
                                try {} catch (e) {}
                                _formKey.currentState?.validate();
                                try {
                                   await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: "${email.text}".trim())
                                    .then((value) => Fluttertoast.showToast(
                                        msg:
                                            "link has been sent to your email for password reset",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0)).then((value) => Get.to(login()));

                                } catch (e) {
                                  Fluttertoast.showToast(
                                        msg:
                                            "$e" == noted ? "The email address is badly formatted" : "$e",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                        print("$e".trim());
                                  
                                }
                               
                                // login2();

                                print("textFieldsValue");
                                // print(email.text);
                                // print(password.text);
                              },
                            )),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
    
  }
  var noted ="[firebase_auth/invalid-email] The email address is badly formatted.";
}

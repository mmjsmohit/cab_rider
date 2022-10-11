import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/widgets/ProgressDialog.dart';
import 'package:cab_rider/widgets/TaxiButton.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../brand_colors.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  static const String id = 'registrationpage';
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final _auth = FirebaseAuth.instance;

  Future<void> registerUser(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: 'Creating your account...'));
    final user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      Navigator.pop(context);
      FirebaseAuthException thisEx = ex;
      print(thisEx.message);
      showSnackBar(thisEx.message!, context);
    }))
        .user;
    if (user != null) {
      var dbRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');
      Map userDetails = {
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };
      dbRef.set(userDetails);
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Create a Rider's Account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TaxiButton(
                          title: 'Sign Up!',
                          color: Colors.black,
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            //Check Network Avaliability.
                            if (!((connectivityResult ==
                                    ConnectivityResult.mobile) ||
                                (connectivityResult ==
                                    ConnectivityResult.wifi))) {
                              showSnackBar(
                                  'Error occured while creating an account.\nPlease make sure you are connected to the Internet!',
                                  context);
                            }

                            //Validate Data.
                            if (fullNameController.text.length < 3) {
                              showSnackBar('Enter a valid full name!', context);
                              return;
                            }

                            if (phoneController.text.length < 10) {
                              showSnackBar(
                                  'Enter a valid phone number!', context);
                              return;
                            }

                            if (!isEmail(emailController.text)) {
                              showSnackBar(
                                  'Enter a valid email address!', context);
                              return;
                            }
                            if (passwordController.text.length < 8) {
                              showSnackBar(
                                  'Please enter a password of atleast 8 characters!',
                                  context);
                            }

                            await registerUser(context);
                            showSnackBar(
                                'Account Created Successfully', context);
                          })
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.id, (route) => false);
                    },
                    child: Text("Already have an account? Sign in here!"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

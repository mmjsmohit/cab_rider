import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:cab_rider/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    //TODO: Implement Login Function to validate email and password.

    //TODO: Redirect User to MainPage after valid input.
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
                  'Sign in As A Rider',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
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
                          title: 'Sign In!',
                          color: Colors.black,
                          onPressed: () async {
                            //Validate the User data and sign in if valid.
                            login();
                          })
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RegistrationPage.id, (route) => false);
                    },
                    child: Text("Don't have an account? Sign Up here!"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

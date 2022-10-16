import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Brand-Regular',
        ),
        initialRoute: assignScreen(),
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
        },
        home: RegistrationPage(),
      ),
    );
  }

  String assignScreen() {
    var user = FirebaseAuth.instance.currentUser;
    String id = LoginPage.id;
    if (user == null) {
      id = LoginPage.id;
    } else {
      id = MainPage.id;
    }
    return id;
  }
}

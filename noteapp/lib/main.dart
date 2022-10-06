
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/auth/login.dart';
import 'package:noteapp/auth/signup.dart';
import 'package:noteapp/crud/addnote.dart';
import 'package:noteapp/firebase_options.dart';
import 'package:noteapp/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteapp/home/test.dart';





late bool isLogin;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLogin=false;
  }else{
    isLogin = true;
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: 'MYNOTE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TestApp(),//isLogin == false ? Login(): Homepage(),
        routes: {
          "login": (context) => Login(),
          "signup": (context) => SignUp(),
          "homepage": (context) => Homepage(),
          "addnotes": (context) => AddNotes(),
        });
  }
}

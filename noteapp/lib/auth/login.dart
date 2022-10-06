// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/component/alert.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   var Myemail,pass;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
 
  login() async{
       var formdata = formstate.currentState;
       if(formdata!.validate()){
        formdata.save();
          try {
            showLoading(context);
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: Myemail,
              password: pass
            );
            return credential; // Done
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
             Navigator.of(context).pop();
              AwesomeDialog(
                      context: context,
                      title: "Error",
                      body: Padding(
                       padding: const EdgeInsets.only(bottom: 20.0),
                        child: const Text("No user found for that email."),
                      ),
              )..show();
             
            } else if (e.code == 'wrong-password') {
               Navigator.of(context).pop();
              AwesomeDialog(
                      context: context,
                      title: "Error",
                      body: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: const Text("The password is wrong."),
                      ),
              )..show();
            }
          }
       }else{
        print("not vaild");
       }
  }



  @override
  Widget build(BuildContext context) {
    var url = 'image/logo.jpg';
    late UserCredential cred;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 10.0,),
            Center(child: Image.asset(url)),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: ((newValue) {
                        Myemail =newValue;
                      }),
                      validator: ((val) {
                        if(val!.length>100){
                          return "Username can't to be  larger 100 letter";
                        }
                         if(val.length<2){
                          return "Username can't to be  less than 2 letter";
                        }
                        return null;
                      }),
                      decoration: const InputDecoration(
                        hintText: 'UserName',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        onSaved: ((newValue) {
                        pass = newValue;
                      }),
                           validator: ((val) {
                        if(val!.length>100){
                          return "Password can't to be  larger 100 letter";
                        }
                         if(val.length<4){
                          return "Password can't to be  less than 4 letter";
                        }
                        return null;
                      }),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, left: 5),
                      child: Row(
                        children: [
                          Text('if u have`t Acount'),
                          InkWell(
                            child: const Text(
                              ' click here',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed('signup');
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 50.0,left: 50.0),
              height: 50,
                child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async{
                      var user = await login();
                      if(user!=null){
                        Navigator.of(context).pushReplacementNamed("homepage");
                      }else{
                        print("Login faild");
                      }

                    })),
          ],
        ),
      ),
    );
  }
}

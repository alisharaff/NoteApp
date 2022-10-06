import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/component/alert.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var MyuserName,Myemail,pass;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
 
 
 SignUp()async{
  var formdata = formstate.currentState;
  if(formdata!.validate()){
    formdata.save();
    try {
      showLoading(context);
           final credential = await FirebaseAuth?.instance.createUserWithEmailAndPassword(
            email: Myemail,
            password: pass,
          );
          return credential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Navigator.of(context).pop();
            AwesomeDialog(
                      context: context, 
                      title: "Error",
                      body: const Text("The password provided is too weak."),
                      )..show();
          } else if (e.code == 'email-already-in-use') {
              Navigator.of(context).pop();
              AwesomeDialog(
                      context: context,
                      title: "Error",
                      body: const Text("The account already exists for that email."),
                    )..show();
          }
        } catch (e) {
          print(e);
}
  }else{
    print('not valid');
  }
 }
 
  @override
  Widget build(BuildContext context) {
    var url = 'image/logo.jpg';
    var url2 = 'image/newlogo.png';

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Center(child: Image.asset(url,)),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                     TextFormField(
                      onSaved: ((newValue) {
                        MyuserName =newValue;
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
                        Myemail =newValue;
                      }),
                           validator: ((val) {
                        if(val!.length>100){
                          return "Email can't to be  larger 100 letter";
                        }
                         if(val.length<2){
                          return "Email can't to be  less than 2 letter";
                        }
                        return null;
                      }),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
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
                      onTap: () {
                        setState(() {
                          url = url2;
                          print(url);
                        });
                      },
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
                          Text('if u have Acount'),
                          InkWell(
                            child: const Text(
                              ' click here',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed("login");
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
              margin: const EdgeInsets.only(top:20.0,right: 50.0,left: 50.0),
              height: 50,
                child: ElevatedButton(
              child: const Text('SignUp'),
              onPressed: ()async {
               var response = await SignUp();
              print("****************************************");
                if(response!=null){
                  await FirebaseFirestore.instance.collection("users").add({
                    "username":MyuserName,
                    "email":Myemail,
                  });
                  Navigator.of(context).pushReplacementNamed("homepage");
                }else{
                  print("Sign up faild");
                }
               print("****************************************");


              },
            )),
          ],
        ),
      ),
    );
  }
}

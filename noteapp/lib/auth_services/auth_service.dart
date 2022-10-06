import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {

  static AuthService instance = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;


  SignWithEmailAndPassword({required String email,required String password})async{

    try{
    UserCredential usercred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print('User ${usercred.user!.email} is Regestered..');
      }
    }catch(e){
        if (kDebugMode) {
          print('there is an exception');
        }
    }
    
  }

   SignInWithEmailAndPassword({required String email,required String password})async{

    try{
    UserCredential usercred = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print('User ${usercred.user!.email} is loggied in..');
      }
    }catch(e){
        if (kDebugMode) {
          print('there is an exception');
        }
    }
    
  }

}









///  login with Google

//  Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
//////////////////
  //  onPressed: () async {
  //                     cred = await signInWithGoogle();
  //                     print(cred.user!.emailVerified);
  //                   }








  //// to get data from firestore
// getData()async{
//   FirebaseFirestore.instance.collection("user").get().then((value) => {
//     value.docs.forEach((element) {
//       print("*************************************************");
//       print(element.data());
//     })
//   });


// }
// @override
//   void initState() {
//    getData();
//     super.initState();
//   }
/////////////////////////////////////////////////
///
///**************StreamBuilder****************************
// body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('note').snapshots(),
//         builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, i) {
//               DocumentSnapshot doc = snapshot.data!.docs[i];
//                return Text(doc['title']);
//               });
//         } 
//         if(snapshot.hasError) {
//          return Text("No data");
//         }
//        return Text("waiting....") ;
//     },
    
// ),
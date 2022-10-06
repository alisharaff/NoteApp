import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  CollectionReference noteRef = FirebaseFirestore.instance.collection("user");
  
  
// late File  file ;
// var imagePicker = ImagePicker();

// uploadImage()async{
//       var imagePicked =await imagePicker.pickImage(source:ImageSource.camera);
         
//          if(imagePicked != null){
//             file =File(imagePicked.path);
//             var nameImage = basename(imagePicked.path);
// // uPload IMG
//             var refstorge = FirebaseStorage.instance.ref("Image").child("$nameImage");
//            try {
//                     await refstorge.putFile(file);
//                   } catch (e) {
//                     // ...
//                     print("ahaaaaaaaaaaaaaaaaaaaaaa..");
//                   }
           
           
//             var url = await refstorge.getDownloadURL();
//             print("========================================");
//             print(url);
//          }else{
//           print("faild......");
//          }     
// }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) =>  Model(),
      child:  Scaffold(
      appBar:AppBar(),
      body:Consumer<Model>(builder: (context,model,child){
        return Column(children: [
          Center(child: Text("${model.name}")),
          ElevatedButton(onPressed: (() {
            model.changName();
          }), child: Text("Chanage Name"))

        ],);
      },)
    

    ));
      
      
  }
}
class Model extends ChangeNotifier{
 String name = "welcom";
 changName(){
    name = "AliSharaf";
    notifyListeners();
 }
}


import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/component/alert.dart';
import 'package:path/path.dart';

class EditNotes extends StatefulWidget {
  final docid;
  final list;
  EditNotes({Key? key,this.docid,this.list}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}
  late Reference  ref;
  late File file;
  CollectionReference noteRef = FirebaseFirestore.instance.collection("notes");
  var userId =FirebaseAuth.instance.currentUser!.uid;
  var titlt, note, imgUrl;

class _EditNotesState extends State<EditNotes> {
 
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  
editNotes(context) async { 
  var formdata = formState.currentState;
  if(formdata!.validate()){
    showLoading(context);
    formdata.save();
    await noteRef.doc(widget.docid).update({
      "title":titlt,
      "note":note,
      "userId":userId,
    });
    Navigator.of(context).pushNamed("homepage");
  
  
  }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formState,
                child: Column(
              children: [
                TextFormField(
                  initialValue: widget.list["title"],
                   validator: ((val) {
                        if(val!.length>30){
                          return "Title can't to be  larger 30 letter";
                        }
                         if(val.length<2){
                          return "Title can't to be  less than 2 letter";
                        }
                        return null;
                      }),
                   
                  onSaved: ((newValue) {
                    titlt = newValue;
                  }),
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title Note",
                      prefixIcon: Icon(Icons.title_outlined)),
                ),
                ////////////////////////////////////
                TextFormField(
                  initialValue: widget.list["note"],
                   validator: ((val) {
                        if(val!.length>255){
                          return "Note can't to be  larger 255 letter";
                        }
                         if(val.length<2){
                          return "Note can't to be  less than 2 letter";
                        }
                        return null;
                      }),
                   onSaved: ((newValue) {
                    note = newValue;
                  }),
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Note",
                      prefixIcon: Icon(Icons.note_add)),
                ),
                ///////////////////////////////////
                ElevatedButton(
                  onPressed: () {
                     showBottomSheet(context);
                  },
                  child: Text("Edit Image"),
                ),
                ElevatedButton(
                  onPressed: () async {
                   
                    await editNotes(context);
                     if(file == null)
                        AwesomeDialog(
                          context: context,
                          title: "note",
                          body: Text("Edit Image.."),
                          dialogType: DialogType.ERROR
                        )..show();
 
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      child: Text(
                        "Edit Note",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
showBottomSheet(context){
  return showModalBottomSheet(context: context,
   builder:((context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 170.0,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text("Please Choose Image",
            style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
        InkWell(
          onTap: (() async{
            var picked = await ImagePicker().pickImage(source: ImageSource.gallery);

            if(picked != null){
               file = File(picked.path);
               var rand = Random().nextInt(1000000);
               var nameimage ="$rand" + basename(picked.name);
               ref= await FirebaseStorage.instance.ref("images/$nameimage");
               Navigator.of(context).pop();
            }

          }),
          child:Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child:Row(children: [
              Icon(Icons.photo_album_outlined,
              size: 30.0,),
              SizedBox(width: 20.0,),
              Text("From Gallery",
              style: TextStyle(fontSize: 20.0),
              ),
            ],
            ) ,
            ) ,
            ),
            ////////////////
             InkWell(
                   onTap: (() async{
            var picked = await ImagePicker().pickImage(source: ImageSource.camera);
            if(picked != null){
               file = File(picked.path);
               var rand = Random().nextInt(1000000);
               var nameimage ="$rand" + basename(picked.name);
               ref= await FirebaseStorage.instance.ref("images/$nameimage");
               Navigator.of(context).pop();
            }

          }),
          child:Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child:Row(children: [
              Icon(Icons.photo_camera,
              size: 30.0,),
              SizedBox(width: 20.0,),
              Text("From Camera",
              style: TextStyle(fontSize: 20.0),
              ),
            ],
            ) ,
            ) ,
            ),
        ]) ,);
   }));
}

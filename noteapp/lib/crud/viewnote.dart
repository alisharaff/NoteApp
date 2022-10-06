import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewNote extends StatefulWidget {
  final notes;
  const ViewNote({Key? key,this.notes}) : super(key: key);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Notes"),
      ),
      body: Container(child: Column(children: [
        SizedBox(height: 10.0,),
          Expanded(
            flex: 2,
            child: Container(child:Image.network("${widget.notes["imgUrl"]}",
            width: double.infinity,
            height: 300.0,
            fit: BoxFit.fill,),),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: Text("${widget.notes["title"]}",
              style:TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),),
            ),
          ),
             Expanded(
              flex: 2,
               child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Color.fromARGB(255, 230, 227, 227)),
                         margin: EdgeInsets.only(top: 15.0),
                         child: Text("${widget.notes["note"]}",
                         style:TextStyle(fontSize: 20.0,color: Colors.black),),
                       ),
             ),
      ],)),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/crud/editnotes.dart';
import 'package:noteapp/crud/viewnote.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}


CollectionReference noteref = FirebaseFirestore.instance.collection("notes");

class _HomepageState extends State<Homepage> {
 
 getToken()async{
  var fbm = await FirebaseMessaging.instance;
  fbm.getToken().then((value){
    print("============Token=============");
    print(value);
  });
}


  getData()async{
  FirebaseFirestore.instance.collection("user").get().then((value) => {
    value.docs.forEach((element) {
      print("*************************************************");
      print(element.data());
    })
  });


}
@override
  void initState() {
    getToken();
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEPAGE'),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed("login");
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushNamed("addnotes");
        }),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: noteref.where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get(),
          builder: ((context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:((context, i) {
                    DocumentSnapshot doc = snapshot.data!.docs[i];
                   return Dismissible(
                    onDismissed: (direction) async{
                      await  noteref.doc(snapshot.data!.docs[i].id).delete();
                      await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[i]['imgUrl']).delete();
                    },
                    key: UniqueKey(), // To Delete Notes by move
                    child: Listnotes(
                      notes: snapshot.data!.docs[i],
                      docid:snapshot.data!.docs[i].id
                    ));
           }) );
            }
            return Center(child: CircularProgressIndicator(),);
          })
          ),
      ),
    );
  }
}

class Listnotes extends StatelessWidget {
  final notes;
  final docid;
  Listnotes({this.notes,this.docid});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewNote(notes: notes,);
        }));
      },
      child: Card(
          child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Image.network(
                "${notes['imgUrl']}",
                fit: BoxFit.fill,
                height: 80.0,
              )),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text("${notes['title']}"),
              subtitle: Text("${notes['note']} "),
              trailing: IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                  return EditNotes(docid: docid,list: notes,);
              })));   
              }, icon: Icon(Icons.edit)),
            ),
          ),
        ],
      )),
    );
  }
}

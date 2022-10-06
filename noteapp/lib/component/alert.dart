import 'package:flutter/material.dart';

showLoading(context){
  return showDialog(context: context, builder: ((context) {
    return AlertDialog(
      title: Text("Please Wait"),
      content: Container(
        height: 50.0,
        child: Center(child: CircularProgressIndicator(),)),
    );
  }));
}

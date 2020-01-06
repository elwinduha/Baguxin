import 'package:baguxin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'createTask.dart';

class MyTask extends StatefulWidget {
  MyTask({this.user,this.googleSignIn});
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {

  void _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 200.0,
        child: new Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            new Padding(padding: const EdgeInsets.all(5.0),
              child: Text("Sign Out?", style: new TextStyle(fontSize: 16.0),),
            ),
            new Divider(),
            new Padding(padding: const EdgeInsets.all(2.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context)=> new MyHomePage())
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                      ),
                      Text("Yes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                      ),
                      Text("Cancel")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context)=> new CreateTask(email: widget.user.email,)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        color: Colors.orange,
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
      body: Container(
        height: 280.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(90.0),
              bottomRight: const Radius.circular(90.0)
            ),
          image: DecorationImage(
            image: new AssetImage("img/bg-04.png"),fit: BoxFit.cover,
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0
            )
          ]
        ),
        child: new Container(
            margin: const EdgeInsets.only(top: 100.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: new NetworkImage(widget.user.photoUrl),fit: BoxFit.cover,
                      )
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 10.0),
                child: new Column(
                  children: <Widget>[
                    new Text(widget.user.displayName, style: new TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                ),
                ),
                new IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30.0,),
                    onPressed: (){
                      _signOut();
                    },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

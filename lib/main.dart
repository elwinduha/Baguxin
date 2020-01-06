import 'package:baguxin/myTask.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> _signIn() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  Navigator.of(context).push(
   new MaterialPageRoute(
        builder: (BuildContext context) => new MyTask(user:user,googleSignIn:_googleSignIn)
    )
  );
}
//Future<FirebaseUser> _signIn() async{
//  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//  GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//  FirebaseUser firebaseUser = await firebaseauth.signInWithGoogle(
//    idToken: googleSignInAuthentication.idToken,
//    accessToken: googleSignInAuthentication.accessToken
//  );
//
//  Navigator.of(context).push(
//    new MaterialPageRoute(
//        builder: (BuildContext context) => new MyTask(user:firebaseUser,googleSignIn:googleSignIn)
//    )
//  );
//}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/bg-04.png"),fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset("img/logo-05.png", width: 300.0,),
            new Padding(padding: const EdgeInsets.only(bottom: 30.0),),
            new InkWell(
              onTap: (){
                _signIn();
              },
              child: new Image.asset("img/tombol-06.png", width: 250.0,),
            )
          ],
        ),
      ),
    );
  }
}

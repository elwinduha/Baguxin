import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTask extends StatefulWidget {
  EditTask({this.title,this.duedate,this.note,this.index});
  final String title;
  final String note;
  final DateTime duedate;
  final index;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  TextEditingController controllerTitle;
  TextEditingController controllernote;

  DateTime _dueDate;
  String _dateText = '';
  String kegiatanBaru;
  String catatan;
  void _editTask(){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot =
          await transaction.get(widget.index);
          await transaction.update(snapshot.reference, {
            "title" : kegiatanBaru,
            "note" : catatan,
            "duedate" : _dueDate
          });
    });
    Navigator.pop(context);
  }

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2100)
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dueDate = widget.duedate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    kegiatanBaru = widget.title;
    catatan = widget.note;

    controllerTitle = new TextEditingController(text: widget.title);
    controllernote = new TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/bg-04.png"), fit: BoxFit.cover
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("baguxin",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontFamily: "SofiaPro"
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Ubah Kegiatan",
                    style: new TextStyle(fontSize: 19.0, color: Colors.white),),
                ),
                Icon(Icons.edit, color: Colors.white, size: 25.0,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controllerTitle,
              onChanged: (String str) {
                setState(() {
                  kegiatanBaru = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.dashboard),
                  hintText: "Kegiatan Baru",
                  border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(child: Text("Tenggat", style: new TextStyle(
                    fontSize: 22.0, color: Colors.black54),)),
                new FlatButton(onPressed: () => _selectDueDate(context),
                  child: Text(_dateText, style: new TextStyle(
                      fontSize: 22.0, color: Colors.black54),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controllernote,
              onChanged: (String str) {
                setState(() {
                  catatan = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: "Catatan",
                  border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.check, size: 40.0,),
                  onPressed: () {
                    _editTask();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 40.0,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
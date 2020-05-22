import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';


class NoteList extends StatelessWidget {
  final Color red = Color.fromRGBO(217, 48, 48, 255);
  final Color black = Color.fromRGBO(255, 255, 225, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(14, 14, 14, 255),
        body: Stack(
          children: <Widget>[
            
            Container(
              margin:
                  EdgeInsets.only(top: 15, left: 67, right: 67, bottom: 0),
              width: 250,
              child: Notes(),
            )
          ],
        ));
  }
}

class Notes extends StatefulWidget {
  @override
  createState() => new NotesState();
}

class NotesState extends State<Notes> {
  // list of curretn notes
  static List<String> _notes = [];

  // add a note

  void _addNote(String note) {
    if (note.length > 0) {
      setState(() => _notes.add(note));
    }
  }

  
  // delete a note

  void _deleteNote(int index) {
    
    setState(() => _notes.removeAt(index));
  }

  //build note widget

  Widget _buildNoteList() {
    return new ListView.builder(
      
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        if (index < _notes.length) {
          return _buildNoteItem(_notes[index], index);
        }
      },
    );
  }

  // build widget

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      backgroundColor: Color.fromRGBO(14, 14, 14, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 250,
            height: 445,
            child: _buildNoteList(),
          ),
          Container(
            width: 250,
            child: addItemButton(),
          )
        ],
      ),
    );
  }

  // push to another sceen for adding note

  void _pushAddNote() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        backgroundColor: Color.fromRGBO(14, 14, 14, 255),
        body: Center(
          
          child: new TextField(
            style: TextStyle(color: Colors.white),
            autofocus: true,
            onSubmitted: (val) {
              _addNote(val);
              Navigator.pop(context);
            },
          ),
        ),
      );
    }));
  }

  // add button for addding note

  Widget addItemButton() {
    return new Container(
      margin: EdgeInsets.only(bottom: 0),
      child: GestureDetector(
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.red,
          
          size: 70,
        ),
        onTap: _pushAddNote,
      ),
    );
  }

  // build note
  Widget _buildNoteItem(String note, int index) {
    return 

        new Card( child: ListTile(
          
          title: new Text(note, style: TextStyle(color: Colors.black, fontFamily: "Roboto", fontSize: 20, fontStyle: FontStyle.normal),),
          trailing: GestureDetector(
            child: Icon(Icons.delete, color: Color.fromRGBO(217, 48, 48, 1),),
            onTap: () => _deleteNote(index),
          )
        ),
      
        );
      
    

    
    
  }
}

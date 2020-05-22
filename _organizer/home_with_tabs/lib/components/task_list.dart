import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoPage extends StatelessWidget {
  final Color red = Color.fromRGBO(217, 48, 48, 1);
  final Color black = Color.fromRGBO(14, 14, 14, 1);

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(14, 14, 14, 255),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(67, 15, 67, 0),
              width: 250,
              child: TaskList(),
            )
          ],
        ));
  }
}

class TaskList extends StatefulWidget {
  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  static List<String> _tasks = List<String>();
  static List<String> _completedTasks = List<String>();
  static double percentage = 0;
  static double finishedTasks = 0;

  final Color red = Color.fromRGBO(217, 48, 48, 1);
  final Color black = Color.fromRGBO(14, 14, 14, 1);



  int count = 0;
  int position;
  SharedPreferences prefs;

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _update();
    
  }

  

  

  @override
  Widget build(BuildContext context) {
    if (_tasks == null ) {
      setState(() {
        _tasks = ["add a task"];
        _completedTasks = ["false"];
      });
    }
    
    return new Scaffold(
      backgroundColor: Color.fromRGBO(14, 14, 14, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(70, 10, 70, 10),
            width: 80,
            height: 80,
            decoration: ShapeDecoration(
                shape: CircleBorder(
              side: BorderSide(width: 5, color: red),
            )),
            child: Text(
              "$percentage %",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Container(
            width: 300,
            height: 350,
            child: _buildTaskList(),
          ),
          Container(
            width: 250,
            child: addItemButton(),
          ),
        ],
      ),
    );
  }

  void checkCompleted() {
    for (int i = 0; i < _completedTasks.length; i++) {
      if (_completedTasks[i] == true) {
        finishedTasks++;
      } else {
        finishedTasks--;
      }
    }
  }

  void updateCircle() {
    print(_tasks.length);
    print(finishedTasks);

    if (_tasks.length == 0 || finishedTasks == 0) {
      percentage = 0;
    } else {
      percentage = finishedTasks / (_tasks.length) * 100;
      percentage = num.parse(percentage.toStringAsFixed(1));
    }
  }

  // add function

  void _addTask(BuildContext context, String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tasks.add(task);
    _completedTasks.add("false");
    prefs.setStringList("Tasks", _tasks);
    
    
  }

  // remove function

  void _removeTask(BuildContext context, String note, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tasks.remove(note);
    _completedTasks.remove(index);
    prefs.setStringList("Tasks", _tasks);
    
  }

  // update the task list

  void _update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tasks = prefs.getStringList("Tasks");
    
  }

  // push to add screen

  // build task list == Widget
  ListView _buildTaskList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _tasks.length,
      itemBuilder: (context, position) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: new Text(_tasks[position]),
            leading: Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 3.0, color: Colors.red),
                left: BorderSide(width: 3.0, color: Colors.red),
                right: BorderSide(width: 3.0, color: Colors.red),
                bottom: BorderSide(width: 3.0, color: Colors.red),
              )),
              width: 20,
              height: 20,
              child: Checkbox(
                activeColor: Colors.red,
                value: null,
                onChanged: (value) {

                  setState(() {
                    value = !value;
                  });
                   

                } ,
                

              ),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                setState(() {
                  _removeTask(context, _tasks[position], position);
                });
              },
            ),
          ),
        );
      },
    );
  }

  // build Widget == Widget

  _appearTextField(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add a note"),
            content: TextField(
              controller: _textFieldController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Add"),
                onPressed: () {
                  setState(() {
                    String name = _textFieldController.text;
                    
                    print(name);
                    _addTask(context, name);
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget addItemButton() {
    return new Container(
      margin: EdgeInsets.only(bottom: 60),
      child: GestureDetector(
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.red,
            size: 70,
          ),
          onTap: () {
            setState(() {
              _appearTextField(context);
            });
          }),
    );
  }

  // build task item == Widget

  
}

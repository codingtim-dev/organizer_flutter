import 'package:flutter/material.dart';
import 'components/notes.dart';
import 'components/task_list.dart';


class MyHome extends StatefulWidget {

  @override 
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin{


  TabController controller;

  @override 
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
  }

  @override 
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      indicatorColor: Color.fromRGBO(217, 48, 48, 1),
      tabs: <Tab>[
        Tab(
          
          child: Text("To-Do")
        ),
        Tab(
          child: Text("Notes"),
        )
      ],

      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
    children: tabs,

    controller: controller,

    );
  }


  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 13, 13, 1),
      appBar: AppBar(
        bottom: getTabBar(),
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      ),
      body: 
        
        getTabBarView(<Widget>[ToDoPage(), NoteList(),])
        
    );
  }

}
import 'dart:convert';
import 'package:startngfluttertask3/API.dart';
import 'package:startngfluttertask3/models/User.dart';
import 'package:startngfluttertask3/UserPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  build(context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Api Retriever",
      theme: ThemeData(
        primarySwatch:Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{
  @override
  createState()=> new HomePageState();

}
class HomePageState extends State{
  var users = new List<User>();

  _getUsers(){
    API.getUsers().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getUsers();
  }
  dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User List"),
      ),
      body: new ListView.builder(
        itemCount: users == null? 0: users.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.asset('assets/avatar.png',),
              title: Text(users[index].name),
            subtitle: Text(users[index].email),

            onTap:() => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => UserPage(
                    post:users[index],
                  ))
            ) ,
          );
        },
      ),
    );
  }
}
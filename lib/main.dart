import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:http/http.dart' as http;

//import 'package:http/http.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  @override
  State<DataFromAPI> createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getUserData() async {
    var response =
        await http.get(Uri.http('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api-app"),
      ),
      body: Container(
        child: Card(child: FutureBuilder(
          future: getUserData(),
          builder: (context , snapshot){
            if(snapshot.data ==null){
              return Container(
                child: Center(
                  child: Text('loading...'),
                  ),
                  );
            }else return ListView.builder(itemCount: snapshot.data.length, itemBuilder: (context, i){
              return ListTile(
                title: Text(snapshot.data[i].name),
                trailing: Text(snapshot.data[i].email),
              );
            }
            );
          },
          ),
      ),
        
      
    ));
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}

import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todos = <String>[];
  String textInput = "";

  void addNewTask({body}) {
    setState(() {
      todos.add(body);
    });

    // DocumentReference documentReference = FirebaseFirestore.instance.collection('ToDoDB').doc(textInput);
    // Map<String, String> tasks = {'taskBody': textInput};
    // documentReference.set(tasks).whenComplete(() => print("$textInput complete"));
  }

  void deleteTask({index}) {
    setState(() {
      todos.remove(todos[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo Application'),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("ToDoDB").snapshots(),
      //   builder: (context, snapshots) {
      //     return ListView.builder(
      body: ListView.builder(
        // itemCount: snapshots.data?.docs.length,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            // DocumentSnapshot documentSnapshot = snapshots.data?.docs[index] as DocumentSnapshot<Object?>;
            return Dismissible(
              // key: Key(index.toString()),
              key: Key(todos[index]),
              child: Card(
                child: ListTile(
                  // title: Text(documentSnapshot['taskBody']),
                  title: Text(todos[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.grey,
                    onPressed: () => deleteTask(index: index),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                margin: const EdgeInsets.all(10),
              ),
              onDismissed: (direction) => deleteTask(index: index),
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить новую задачу',
        // backgroundColor: Colors.blue,
        child: const Icon(Icons.note_add_outlined, color: Colors.white,),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить задачу'),
              content: TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: 'Введите текст',
                  border: UnderlineInputBorder(),
                ),
                onChanged: (String value) {
                  textInput = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      textInput = "";
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text('ОТМЕНА')),
                TextButton(
                    onPressed: () {
                      if (textInput != "") addNewTask(body: textInput);
                      textInput = "";
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text('ОК')
                ),
              ],
            );
          });
        },
      ),
    );
  }
}

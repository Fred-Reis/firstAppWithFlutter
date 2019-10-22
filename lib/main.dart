import 'package:flutter/material.dart';
import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(tittle: "Item 1", done: false));
    items.add(Item(tittle: "Item 2", done: true));
    items.add(Item(tittle: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variavel recebe do input
  var newTask = TextEditingController();

  //função que altera estado com o nome de add
  void add() {
    if (newTask.text.isEmpty) return;

    setState(() {
      widget.items.add(
        Item(tittle: newTask.text, done: false),
      );
      newTask.clear();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTask, //captura do input
          keyboardType: TextInputType.text, //Input
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            labelText: "Novo item",
            labelStyle: TextStyle(color: Colors.white60),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.tittle),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                });
                print(value);
              },
            ),
            key: Key(item.tittle),
            background: Container(
              color: Colors.red[400],
            ),
            onDismissed: (direction) {
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add, //passando a função
        child: Icon(Icons.fiber_new),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

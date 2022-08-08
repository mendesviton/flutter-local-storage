import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController input = TextEditingController();

  final storage = LocalStorage('data.json');

  saveInfoStorage() async {
    await storage.setItem('title', input.text);
    setState(() {});
  }

  removeInfoStorage() async {
    storage.deleteItem('title');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              removeInfoStorage();
            },
            child: const Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: () {
              saveInfoStorage();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: input,
            decoration: InputDecoration(hintText: 'Escreva algo'),
          ),
          FutureBuilder(
            future: storage.ready,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                var title = storage.getItem('title');
                return Text(
                  title ?? "",
                  style: TextStyle(color: Colors.black),
                );
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

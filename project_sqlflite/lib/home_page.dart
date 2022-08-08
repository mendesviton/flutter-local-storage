import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_sqlflite/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController input = TextEditingController();

  Future saveText() async {
    if (input.text.isNotEmpty) {
      var response = await dbHelper.insertText(input.text);
      print(response);
      if (response == 0) {
        print('Deu erro ao salvar');
      }
    }
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getAllText() async {
    return dbHelper.getAllText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveText();
        },
      ),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: input,
            decoration: const InputDecoration(hintText: 'Coloque o título'),
          ),
          FutureBuilder(
            future: getAllText(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data![index].toString());
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}

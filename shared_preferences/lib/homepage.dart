import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _prefs = SharedPreferences.getInstance();

  TextEditingController input = TextEditingController();
  saveInfoStorage() async {
    final myPrefs = await _prefs;
    await myPrefs.setString('title', input.text);
    setState(() {});
  }

  @override
  void initState() {}

  removeInfoStorage() async {
    final myPrefs = await _prefs;
    await myPrefs.remove('title');
    setState(() {});
  }

  Future<String> getInfoStorage() async {
    return _prefs.then((value) => value.getString('title') ?? '');
  }

  removeAllInfoStorage() async {
    final myPrefs = await _prefs;
    await myPrefs.clear();
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
            child: Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: () {
              saveInfoStorage();
            },
            child: Icon(Icons.add),
          )
        ],
      ),
      appBar: AppBar(
        title: const Text('Shared preference'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: input,
            decoration: const InputDecoration(hintText: 'Escreva algo'),
          ),
          FutureBuilder(
            future: getInfoStorage(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

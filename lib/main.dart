// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = ["Item 1", "Item 2", "Item 3"];
  late SharedPreferences prefs;
  String storedText = "";

  @override
  void initState() {
    super.initState();
    _loadStoredText();
  }

  Future<void> _loadStoredText() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      storedText = prefs.getString('storedText') ?? "Texto não encontrado";
    });
  }

  Future<void> _saveText(String text) async {
    await prefs.setString('storedText', text);
    setState(() {
      storedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
      ),
      body: Column(
        children: [
          Text(
            'Texto salvo: $storedText',
            style: const TextStyle(fontSize: 18),
          ),
          ElevatedButton(
            onPressed: () {
              _saveText("Novo texto salvo");
            },
            child: const Text('Salvar Texto'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(item: items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Center(
        child: Text(
          'Detalhes sobre $item',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

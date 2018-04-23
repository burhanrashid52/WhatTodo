/*
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'chat_screen.dart';
import 'camera_screen.dart';
import 'call_screen.dart';
import 'status_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup name generator',
      theme:
          new ThemeData(accentColor: Colors.white, primaryColor: const Color(0xFF128C7E)),
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
              title: new Text("Hello World"),
              bottom: new TabBar(isScrollable: false, tabs: [
                new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Text("TAB 1")),
                new Text("TAB 2"),
                new Text("TAB 3"),
              ]),
              actions: <Widget>[
                new Icon(Icons.search),
                new Icon(Icons.more_vert)
              ]),
          body: new TabBarView(children: [
            new ChatScreen(),
            new StatusScreen(),
            new CallScreen(),
          ]),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerfonts = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = 1 ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index], index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      */
/* appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),*//*

      body: new Center(
        child: _buildSuggestions(),
      ),
    );
    //  final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
  }

  Widget _buildRow(WordPair suggestion, int index) {
    return new ListTile(title: new Text(index.toString(), style: _biggerfonts));
  }
}
*/

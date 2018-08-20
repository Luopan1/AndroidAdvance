import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firstflutter/toast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Application", //任务管理器中显示当前页面的名字
      home: new RandonWords(),
      theme: new ThemeData(primaryColor: Colors.white),
    );
  }
}

class RandonWords extends StatefulWidget {
  @override
  _RandonWorldState createState() => _RandonWorldState();
}

class _RandonWorldState extends State<RandonWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("持续滚动的listView"),
        elevation: 0.0,
        actions: <Widget>[new IconButton(icon:new Icon(Icons.list),onPressed:_pushSaved)],
      ),
      body: _buildSuggestion(),
    );
  }

  Widget _buildSuggestion() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider(); //判断是否是基数，0是偶数
          final index = i ~/
              2; //语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5时，结果0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          if (index >= _suggestion.length) {
            _suggestion.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestion[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadSaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new IconButton(
        icon:alreadSaved ? new Icon(Icons.favorite) : new Icon(Icons.favorite_border),
        color: alreadSaved ? Colors.red : null,
        onPressed: (){
          setState(() {
            if (alreadSaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
     /* onTap: () {
        setState(() {

        });
      },*/
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

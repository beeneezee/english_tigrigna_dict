import 'package:english_tigrigna_dict/models/entry.dart';
import 'package:flutter/material.dart';
import 'databases/database_helper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite Database Demo',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: new MyHomePage(title: 'English Tigrigna Dictionary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  //final duplicateItems2 = getAllEntries();

  final duplicateItems = List<String>.generate(10000, (i) => "Item number $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> positiveListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          positiveListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(positiveListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  getItemAndNavigate(String item, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(itemHolder: item)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                    onTap: () =>
                        {getItemAndNavigate('${items[index]}', context)},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Entry>> getAllEntries() async {
  DatabaseHelper con = new DatabaseHelper();
  var dbClient = await con.db;
  var res = await dbClient.query("Entry");

  List<Entry> list =
      res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : null;
  // List<Map> title = await dbClient.rawQuery('SELECT title FROM Article');
  print(list);
  return list;
}

class SecondScreen extends StatelessWidget {
  final String itemHolder;

  SecondScreen({Key key, @required this.itemHolder}) : super(key: key);

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(itemHolder),
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            'Selected Item = ' + itemHolder,
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.start,
          ),
        ));
  }
}

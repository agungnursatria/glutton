import 'package:flutter/material.dart';
import 'package:glutton_example/eat_class/eat_class_page.dart';
import 'package:glutton_example/eat_date/eat_date_page.dart';
import 'package:glutton_example/eat_enum/eat_enum_page.dart';
import 'package:glutton_example/eat_uri/eat_uri_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = ThemeData.light();
    return MaterialApp(
      title: 'Glutton Example',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: _themeData.copyWith(
        primaryColor: Colors.purple,
        buttonTheme: _themeData.buttonTheme.copyWith(
          buttonColor: Colors.purple,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List _possibleEaten = [
    'List',
    'Set',
    'Map (can eat json here)',
    'DateTime',
    'String',
    'bool',
    'int (can eat enum index here)',
    'double'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Glutton Example'),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Example eat & vomit class',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EatClassPage(),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Example eat & vomit enum',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EatEnumPage(),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Example eat & vomit date',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EatDatePage(),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Example eat & vomit uri',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EatUriPage(),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(),
                SizedBox(height: 8.0),
                Text(
                  'Glutton Food',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Edible data type:',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                ..._possibleEaten
                    .map(
                      (value) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '- $value',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ));
  }
}

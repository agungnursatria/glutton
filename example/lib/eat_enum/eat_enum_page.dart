import 'package:flutter/material.dart';
import 'package:glutton/glutton.dart';
import 'package:glutton_example/eat_enum/enum_season.dart';

class EatEnumPage extends StatefulWidget {
  @override
  _EatEnumPageState createState() => _EatEnumPageState();
}

class _EatEnumPageState extends State<EatEnumPage> {
  static const String seasonKey = "seasonKey";
  Season selectedValue = Season.Spring;
  String vomittedValue = '-';

  eatEnum(BuildContext context, Season season) async {
    String snackbarContent;

    /// 1. Retrieve index of enum
    int seasonIndex = season.index;

    /// 2. Save index inside glutton
    bool isSuccess = await Glutton.eat(seasonKey, seasonIndex);
    snackbarContent = (isSuccess)
        ? 'Yay! glutton eating the $seasonKey value!'
        : 'Awww! there is something wrong';
    final snackBar = SnackBar(content: Text(snackbarContent));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      selectedValue = season;
    });
  }

  vomitEnum(BuildContext context) async {
    /// 1. Retrieve index inside glutton
    int? index = await Glutton.vomit(seasonKey);

    /// 2. Transform index to enum
    Season? _season = SeasonManager.fromIndex(index);

    setState(() {
      vomittedValue = (_season == null) ? '-' : _season.toString().substring(7);
    });
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Eat & Vomit Enum'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Builder(
        builder: (scaffoldContext) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Eat season enum value',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Save data from secured storage',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButton(
                  items: [
                    Season.Spring,
                    Season.Summer,
                    Season.Fall,
                    Season.Winter,
                  ]
                      .map(
                        (value) => DropdownMenuItem(
                          child: Text(value.toString().substring(7)),
                          value: value,
                        ),
                      )
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) => eatEnum(
                    scaffoldContext,
                    value as Season,
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(),
                SizedBox(height: 8.0),
                Text(
                  'Vomit season enum value',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Retrieve data from secured storage',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  vomittedValue,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      'Vomit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      hideKeyboard(context);
                      vomitEnum(scaffoldContext);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

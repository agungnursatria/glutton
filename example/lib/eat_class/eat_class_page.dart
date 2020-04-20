import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glutton/glutton.dart';
import 'package:glutton_example/eat_class/user.dart';

class EatClassPage extends StatefulWidget {
  @override
  _EatClassPageState createState() => _EatClassPageState();
}

class _EatClassPageState extends State<EatClassPage> {
  TextEditingController _controllerName;
  TextEditingController _controllerAge;

  String vomittedUserText = '-';

  String userKey = "userKey";

  Future eatUser(BuildContext context) async {
    String snackbarContent;
    if (_controllerName.text.isEmpty || _controllerAge.text.isEmpty) {
      snackbarContent = 'Invalid data, please fill the empty field';
    } else {
      ///
      /// 1. Create user object
      User user = User(
        name: _controllerName.text,
        age: int.parse(_controllerAge.text),
        createdAt: DateTime.now(),
      );

      /// 2. Transform user object to map
      Map<String, dynamic> userMap = user.toJson();

      /// 3. Save user map inside glutton
      bool isSuccess = await Glutton.eat(userKey, userMap);
      snackbarContent = (isSuccess)
          ? 'Yay! glutton eating the $userKey value!'
          : 'Awww! there is something wrong';
      setState(() {
        _controllerName.clear();
        _controllerAge.clear();
      });
    }

    final snackBar = SnackBar(content: Text(snackbarContent));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future vomitUser(BuildContext context) async {
    /// 1. Retrieve user map inside glutton
    Map<String, dynamic> userMap = await Glutton.vomit(userKey);
    if (userMap != null) {
      /// 2. Transform user map to user object
      User user = User.fromJson(userMap);
      setState(() {
        vomittedUserText =
            'Name: ${user.name}\nAge: ${user.age}\nCreatedAt: ${user.createdAt}';
      });
    } else {
      final snackBar =
          SnackBar(content: Text('Awww! data not found from key: $userKey'));
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        vomittedUserText = 'Data not found';
      });
    }
  }

  Future digestUser(BuildContext context) async {
    bool isSuccess = await Glutton.digest(userKey);
    String snackbarContent = (isSuccess)
        ? 'Success digesting $userKey value'
        : '$userKey value is not found';
    final snackBar = SnackBar(content: Text(snackbarContent));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerAge = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Eat & Vomit Class'),
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
                  'Eat user class object',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Saving data to secured storage',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.0,
                  ),
                ),
                TextFormField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    hintText: 'Input your name...',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _controllerAge,
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Input your age...',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    child: Text('Eat'),
                    onPressed: () async {
                      hideKeyboard(context);
                      await eatUser(scaffoldContext);
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(),
                SizedBox(height: 8.0),
                Text(
                  'Vomit user class object',
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
                  vomittedUserText,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    child: Text('Vomit'),
                    onPressed: () async {
                      hideKeyboard(context);
                      await vomitUser(scaffoldContext);
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Digest user',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Remove data from secured storage',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.0,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    child: Text('Digest'),
                    onPressed: () async {
                      hideKeyboard(context);
                      await digestUser(scaffoldContext);
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

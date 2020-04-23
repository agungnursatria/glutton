import 'package:flutter/material.dart';
import 'package:glutton/glutton.dart';

class EatUriPage extends StatefulWidget {
  @override
  _EatUriPageState createState() => _EatUriPageState();
}

class _EatUriPageState extends State<EatUriPage> {
  TextEditingController _controllerFullUriString;
  Uri shownUri;

  String uriKey = 'urlKey';

  @override
  void initState() {
    _controllerFullUriString = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerFullUriString.dispose();
    super.dispose();
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future eat(BuildContext context) async {
    String snackbarContent;
    if (_controllerFullUriString.text.isEmpty) {
      snackbarContent = 'Invalid data, please fill the empty field';
    } else {
      /// 1. Create Uri
      Uri _urii = Uri.parse(_controllerFullUriString.text);

      /// 2. Validate uri following RFC 3986 (optional)
      if (_urii.isAbsolute) {
        /// 3. Save uri inside glutton
        bool isSuccess = await Glutton.eat(uriKey, _urii);
        snackbarContent = (isSuccess)
            ? 'Yay! glutton eating the $uriKey value!'
            : 'Awww! there is something wrong';
        setState(() {
          _controllerFullUriString.clear();
        });
      } else {
        snackbarContent = 'Invalid data, please fill the right uri';
      }
    }

    final snackBar = SnackBar(content: Text(snackbarContent));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future vomit(BuildContext context) async {
    /// 1. Retrieve user map inside glutton
    shownUri = await Glutton.vomit(uriKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Eat & Vomit Uri'),
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
                  'Eat uri object',
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
                  controller: _controllerFullUriString,
                  decoration: InputDecoration(
                    hintText: 'Input your uri...',
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    child: Text('Eat'),
                    onPressed: () async {
                      hideKeyboard(context);
                      await eat(scaffoldContext);
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(),
                SizedBox(height: 8.0),
                Text(
                  'Vomit uri value',
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
                  (shownUri == null) ? '-' : shownUri.toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Instance: ${shownUri.runtimeType}',
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
                      await vomit(scaffoldContext);
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

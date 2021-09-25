import 'package:flutter/material.dart';
import 'package:glutton/glutton.dart';
import 'package:intl/intl.dart';

class EatDatePage extends StatefulWidget {
  @override
  _EatDatePageState createState() => _EatDatePageState();
}

class _EatDatePageState extends State<EatDatePage> {
  static const String _dateKey = 'dateKey';
  late TextEditingController _controller;
  late DateTime _selectedDate;

  DateTime? _vomittedSelectedDate;

  @override
  void initState() {
    _controller = TextEditingController();
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _handleOnSelectDate(BuildContext context) async {
    /// Save: 1. Set selected date
    await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    ).then((newDate) {
      if (newDate == null) return;
      setState(() {
        _selectedDate = newDate;
      });
    });
  }

  Future eatDate(BuildContext context) async {
    String snackbarContent;

    /// Save: 2. Save selected date inside glutton
    bool isSuccess = await Glutton.eat(_dateKey, _selectedDate);
    snackbarContent = (isSuccess)
        ? 'Yay! glutton eating the $_dateKey value!'
        : 'Awww! there is something wrong';
    final snackBar = SnackBar(content: Text(snackbarContent));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future vomitEnum(BuildContext context) async {
    /// Retrieve: 1. Retrieve selected date inside glutton
    _vomittedSelectedDate = await Glutton.vomit(_dateKey);
    setState(() {});
  }

  String formattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Eat & Vomit Date'),
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
                  'Eat date value',
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
                TextFormField(
                  controller: _controller,
                  // onChanged: onChanged,
                  onTap: () {
                    _handleOnSelectDate(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: Icon(
                          Icons.calendar_today,
                          size: 24,
                        ),
                      ),
                    ),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff1a1e24), width: 0.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    hintText: formattedDate(_selectedDate),
                  ),
                  style: TextStyle(color: Color(0xffcde1fb)),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      'Eat',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      eatDate(scaffoldContext);
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(),
                SizedBox(height: 8.0),
                Text(
                  'Vomit date value',
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
                  (_vomittedSelectedDate == null)
                      ? '-'
                      : formattedDate(_vomittedSelectedDate!),
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
                    onPressed: () => vomitEnum(scaffoldContext),
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

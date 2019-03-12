import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest App',
    home: new SIForm(),
    theme: ThemeData(
      accentColor: Colors.orangeAccent,
      brightness: Brightness.dark,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  TextEditingController _principalController = new TextEditingController();
  TextEditingController _rateController = new TextEditingController();
  TextEditingController _termController = new TextEditingController();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';
  var displayResult = '';

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text(
          'Simple Interest!',
          style:
              new TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: new Form(
            key: _formKey,
            child: new ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Center(
                    child: new Image.asset(
                  'images/money.png',
                  width: 150.0,
                  height: 150.0,
                )),
                new TextFormField(
                  controller: _principalController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Amount',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  validator: (String value) {
                    // ignore: unrelated_type_equality_checks
                    if (value.isEmpty) return 'Please Enter the Principal Sum';
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                new TextFormField(
                  controller: _rateController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Rate',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      labelStyle: textStyle,
                      hintText: 'Enter Rate of Interest',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please Enter Rate of Interest';
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: new TextFormField(
                      controller: _termController,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) return 'Please Enter Term';
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          hintText: 'Enter number of Years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValue) {
                        _dropdownselected(newValue);
                      },
                    )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          color: Colors.blue[800],
                          child: Text(
                            'Calculate',
                            style: new TextStyle(
                              color: Colors.black38,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate())
                                this.displayResult = calculateInterest();
                            });
                          }),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                          color: Colors.red[600],
                          child: Text(
                            'Reset',
                            style: new TextStyle(
                              color: Colors.black38,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _resetAllFields();
                            });
                          }),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        this.displayResult,
                        style: new TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  //to determine the selected currency
  void _dropdownselected(String newValue) {
    setState(() {
      this._currentItemSelected = newValue;
    });
  }

  String calculateInterest() {
    double principal = double.parse(_principalController.text);
    double rate = double.parse(_rateController.text);
    double term = double.parse(_termController.text);

    double amountReturn;
    amountReturn = principal + (principal * rate * term) / 100;

    String result =
        'After $term years, your investment will be worth $amountReturn $_currentItemSelected';
    return result;
  }

  void _resetAllFields() {
    _principalController.text = '';
    _rateController.text = '';
    _termController.text = '';
    _currentItemSelected = _currencies[0];
    displayResult = '';
  }
}

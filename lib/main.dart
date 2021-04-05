import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var t1;
  var t2;

  var order = false;
  var counter = 0;
  var name = TextEditingController();
  var val = false;
  var wcval = false;
  var wcp;
  var cp;
  adder() {
    setState(() {
      counter = counter + 1;
    });
  }

  subtractor() {
    setState(() {
      counter = counter - 1;
    });
  }

  summary() {
    setState(() {
      order = true;
    });
  }

  reset() {
    setState(() {
      order = false;
      counter = 0;
      val = false;
      wcval = false;
      name.clear();
    });
  }

  void emailer(cmd) async {
    if (await canLaunch(cmd)) {
      await launch(cmd);
    } else {
      print(' could not launch $cmd');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (wcval == true)
      wcp = 50;
    else
      wcp = 0;
    if (val == true)
      cp = 50;
    else
      cp = 0;
    var total = counter * 100 + wcp + cp;
    if (wcval == true)
      t1 = 'whipping cream';
    else
      t1 = '';
    if (val == true)
      t2 = 'chocolate';
    else
      t2 = '';
    var cmd =
        'mailto:your@email.com?subject=Your%20Order&body=Name%20\n$t1\n+$t2\nQuantity=$counter\nTotal=Rs: $total ';

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromRGBO(255, 233, 212, 1),
      appBar: AppBar(
        title: Text('Coffee'),
        backgroundColor: Color.fromRGBO(165, 63, 42, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter Name'),
              controller: name,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'TOPPINGS',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text(
                'Whipped Cream',
                style: TextStyle(fontSize: 20),
              ),
              onChanged: (y) {
                setState(() {
                  wcval = y;
                });
              },
              value: wcval,
            ),
            CheckboxListTile(
              title: Text('Chocolate', style: TextStyle(fontSize: 20)),
              onChanged: (x) {
                setState(() {
                  val = x;
                });
              },
              value: val,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'QUANTITY',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: adder,
                  color: Colors.white,
                ),
                Text(
                  '$counter',
                  style: TextStyle(fontSize: 30),
                ),
                RaisedButton(
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: counter == 0 ? () {} : subtractor,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Order Summary',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                if (order == true)
                  Text(
                    'Name:   ${name.text}',
                    style: TextStyle(fontSize: 25),
                  ),
                if (wcval == true && order == true)
                  Text('+Whipped Cream', style: TextStyle(fontSize: 25)),
                if (val == true && order == true)
                  Text('+Chocolate', style: TextStyle(fontSize: 25)),
                if (order == true)
                  Text('Quantity: $counter', style: TextStyle(fontSize: 25)),
                if (order == true)
                  Text('Total: Rs $total', style: TextStyle(fontSize: 25))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            RaisedButton(
              child: Text('Order'),
              onPressed: counter == 0 ? () {} : summary,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text('RESET'),
                  onPressed: reset,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                RaisedButton(
                  child: Text('EMAIL ORDER'),
                  onPressed: () => emailer(cmd),
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info = "Informe seus dados";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe seus dados";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18) {
        _info = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18 && imc < 24.9) {
        _info = "Peso idal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Acima do peso (${imc.toStringAsPrecision(2)})";
      } else {
        _info = "Gordo pra kct (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("calculadora de imc"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetField();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 120, color: Colors.amber),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso em KG",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              textAlign: TextAlign.center,
              controller: weightController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura em CM",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              textAlign: TextAlign.center,
              controller: heightController,
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              height: 100,
              child: RaisedButton(
                onPressed: () {
                  calculate();
                },
                child: Text(
                  "calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                color: Colors.amber,
              ),
            ),
            Text(
              "$_info",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

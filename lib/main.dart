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

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  String _resultado = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    peso.text = "";
    altura.text = "";

    setState(() {
      _resultado = "Informe seus dados";
    });
  }

  void _calculate(){
    setState(() {
      double alt = double.parse(altura.text) / 100;
      double p = double.parse(peso.text);
      double imc = p / (alt * alt);

      if (imc < 18) {
        _resultado = "Abaixo do peso (IMC = ${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 18 && imc < 25) {
        _resultado = "Peso ideal (IMC = ${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 25 && imc < 30) {
        _resultado = "Acima do peso (IMC = ${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 30 && imc < 35) {
        _resultado = "Obesidade Grau I (IMC = ${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 35 && imc < 40) {
        _resultado = "Obesidade Grau II (IMC = ${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 40) {
        _resultado = "Obesidade Grau III (IMC = ${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  validator: (valor){
                    if (valor.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                  controller: peso,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                TextFormField(
                  validator: (valor){
                    if (valor.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                  controller: altura,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ],
            ),
          )
        ));
  }
}

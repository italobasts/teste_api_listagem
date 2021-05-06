import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testanto_api/model/model_produtos.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelProdutos> _modelProdutosList = [];

  Future<List<ModelProdutos>> fetchProdutos() async {
    //conecta com a api
    var url = "https://teste-produtos.herokuapp.com/api/produtos";
    var response = await http.get(Uri.parse(url));

    //cria uma lista
    List<ModelProdutos> listaDeProdutos = [];

    if (response.statusCode == 200) {
      var produtosDados = json.decode(response.body);
      for (produtosDados in produtosDados) {
        listaDeProdutos.add(ModelProdutos.fromJson(produtosDados));
      }
    } else {
      return null;
    }
    return listaDeProdutos;
  }

  @override
  void initState() {
    fetchProdutos().then((value) {
      setState(() {
        _modelProdutosList.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: fetchProdutos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nome: ${_modelProdutosList[index].nome}",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Id: ${_modelProdutosList[index].id}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text("Qtd: ${_modelProdutosList[index].quantidade}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        Text("Valor: ${_modelProdutosList[index].valor}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _modelProdutosList.length,
            );
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          ));
        },
      ),
    );
  }
}

/*

*/

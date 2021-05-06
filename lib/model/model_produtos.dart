// To parse this JSON data, do
//
//     final modelProdutos = modelProdutosFromJson(jsonString);

import 'dart:convert';

List<ModelProdutos> modelProdutosFromJson(String str) =>
    List<ModelProdutos>.from(
        json.decode(str).map((x) => ModelProdutos.fromJson(x)));

String modelProdutosToJson(List<ModelProdutos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProdutos {
  ModelProdutos({
    this.id,
    this.nome,
    this.quantidade,
    this.valor,
  });

  int id;
  String nome;
  double quantidade;
  double valor;

  factory ModelProdutos.fromJson(Map<String, dynamic> json) => ModelProdutos(
        id: json["id"],
        nome: json["nome"],
        quantidade: json["quantidade"] == null ? null : json["quantidade"],
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "quantidade": quantidade == null ? null : quantidade,
        "valor": valor == null ? null : valor,
      };
}

import 'dart:core';

class Usua {
  String idUsu;
  String id;
  String nome;
  String cpf;
  String email;
  num preco;
  String? servico;
  String? status;
  String? data;
  String? anotacoes;
  List<String> docs;

  Usua({
    this.idUsu = '',
    this.id = '',
    this.docs = const [],
    required this.nome,
    required this.cpf,
    required this.email,
    required this.preco,
    required this.servico,
    required this.status,
    required this.data,
    required this.anotacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUsu': idUsu,
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'preco': preco,
      'servico': servico,
      'status': status,
      'data': data,
      'anotacoes': anotacoes,
      'docs': docs,
    };
  }

  factory Usua.fromJson(Map<String, dynamic> json) {
    return Usua(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      preco: json['preco'],
      servico: json['servico'],
      status: json['status'],
      data: json['data'],
      anotacoes: json['anotacoes'],
      docs: json['docs'] != null
          ? (json['docs'] as List).map((item) => item as String).toList()
          : [],
    );
  }

  deleteUserDoc(String docName) {
    docs.removeWhere((doc) => doc == docName);
  }

  addUserDoc(String docName) {
    docs.add(docName);
  }
}

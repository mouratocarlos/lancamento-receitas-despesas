class MovimentacaoFinanceiraEntity {
  int id;
  String data;
  double valor;
  int listaFormaBaixa;
  int listaTipoEspecie;
  String observacao;

  MovimentacaoFinanceiraEntity({
    required this.id,
    required this.data,
    required this.valor,
    required this.listaFormaBaixa,
    required this.listaTipoEspecie,
    required this.observacao,
  });

  factory MovimentacaoFinanceiraEntity.fromJson(Map<String, dynamic> json) {
    return MovimentacaoFinanceiraEntity(
      id: json["id"] as int,
      data: json["data"] as String,
      valor: json["valor"] as double,
      listaFormaBaixa: json["listaFormaBaixa"] as int,
      listaTipoEspecie: json["listaTipoEspecie"] as int,
      observacao: json["observacao"] as String,
    );
  }
}

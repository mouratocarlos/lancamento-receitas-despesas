class MovimentacaoFinanceiraDto {
  int id;
  String data;
  double valor;
  int listaFormaBaixa;
  int listaTipoEspecie;
  String formaBaixa;
  String tipoEspecie;
  String observacao;

  MovimentacaoFinanceiraDto({
    required this.id,
    required this.data,
    required this.valor,
    required this.listaFormaBaixa,
    required this.listaTipoEspecie,
    required this.formaBaixa,
    required this.tipoEspecie,
    required this.observacao,
  });

  factory MovimentacaoFinanceiraDto.fromJson(Map<String, dynamic> json) {
    return MovimentacaoFinanceiraDto(
      id: json["id"] as int,
      data: json["data"] as String,
      valor: json["valor"] as double,
      listaFormaBaixa: json["listaFormaBaixa"] as int,
      listaTipoEspecie: json["listaTipoEspecie"] as int,
      formaBaixa: json["formaBaixa"] as String,
      tipoEspecie: json["tipoEspecie"] as String,
      observacao: json["observacao"] as String,
    );
  }
}

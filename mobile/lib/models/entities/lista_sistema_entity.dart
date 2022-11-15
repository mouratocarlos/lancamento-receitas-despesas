class ListaSistemaEntity {
  int id;
  String tipo;
  String codigo;
  String descricao;

  ListaSistemaEntity({
    required this.id,
    required this.tipo,
    required this.codigo,
    required this.descricao,
  });

  factory ListaSistemaEntity.fromJson(Map<String, dynamic> json) {
    return ListaSistemaEntity(
      id: json["id"] as int,
      tipo: json["tipo"] as String,
      codigo: json["codigo"] as String,
      descricao: json["descricao"] as String,
    );
  }
}

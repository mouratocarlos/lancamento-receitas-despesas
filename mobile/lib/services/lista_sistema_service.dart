import 'package:dio/dio.dart';
import 'dart:io';
import 'package:lancamentos_receitas_despesas/models/entities/lista_sistema_entity.dart';

class ListaSistemaService {
  final Dio _dio = Dio();
  final _path = "http://localhost:8090/lista-sistema";

  Future<List<ListaSistemaEntity>> recuperarFormasBaixa() async {
    try {
      Response response = await _dio.get("$_path?tipo=FORMA_BAIXA");

      List<ListaSistemaEntity> lista = List<ListaSistemaEntity>.empty();

      for (Map<String, dynamic> json in response.data) {
        lista = List.from(lista)..add(ListaSistemaEntity.fromJson(json));
      }

      return lista;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<ListaSistemaEntity>> recuperarEspecies() async {
    try {
      Response response = await _dio.get("$_path?tipo=TIPO_ESPECIE");

      List<ListaSistemaEntity> lista = List<ListaSistemaEntity>.empty();

      for (Map<String, dynamic> json in response.data) {
        lista = List.from(lista)..add(ListaSistemaEntity.fromJson(json));
      }

      return lista;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }
}

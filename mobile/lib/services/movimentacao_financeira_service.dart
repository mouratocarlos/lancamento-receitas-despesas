import 'package:dio/dio.dart';
import 'dart:io';
import 'package:lancamentos_receitas_despesas/models/dtos/movimentacao_financeira_dto.dart';
import 'package:lancamentos_receitas_despesas/models/entities/movimentacao_financeira_entity.dart';

class MovimentacaoFinanceiraService {
  final Dio _dio = Dio();
  final _path = "http://localhost:8090/movimentacao-financeira";

  Future<List<MovimentacaoFinanceiraDto>> recuperarMovimentacoes(
      String date) async {
    try {
      Response response = await _dio.get("$_path?data=$date");

      List<MovimentacaoFinanceiraDto> lista =
          List<MovimentacaoFinanceiraDto>.empty();

      for (Map<String, dynamic> json in response.data) {
        lista = List.from(lista)..add(MovimentacaoFinanceiraDto.fromJson(json));
      }

      return lista;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  void post(MovimentacaoFinanceiraEntity entity) async {
    try {
      await _dio.post(_path, data: entity);
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  void delete(MovimentacaoFinanceiraEntity entity) async {
    try {
      await _dio.delete(_path, data: entity);
    } catch (e) {
      throw SocketException(e.toString());
    }
  }
}

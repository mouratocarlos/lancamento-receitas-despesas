import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lancamentos_receitas_despesas/models/dtos/movimentacao_financeira_dto.dart';
import 'package:lancamentos_receitas_despesas/models/entities/movimentacao_financeira_entity.dart';

class MovimentacaoFinanceiraService {
  final Dio _dio = Dio();
  final _path = "http://localhost:8090/movimentacao-financeira";

  void _showModal(BuildContext context, bool isError) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: isError
                    ? const Icon(Icons.cancel)
                    : const Icon(Icons.check_box),
                title: isError
                    ? const Text('Ocorreu um erro no processo')
                    : const Text('Operação realizada com sucesso'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

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

  Future<void> post(
      BuildContext context, MovimentacaoFinanceiraEntity entity) async {
    try {
      await _dio.post(_path, data: jsonEncode(entity.toJson())).then((value) {
        Navigator.of(context).pop();
        _showModal(context, false);
      });
    } catch (e) {
      Navigator.of(context).pop();
      _showModal(context, true);
      throw SocketException(e.toString());
    }
  }

  Future<void> delete(BuildContext context, int id) async {
    try {
      await _dio.delete(_path, data: {
        'id': id,
      }).then((value) => {_showModal(context, false)});
    } catch (e) {
      _showModal(context, true);
      throw SocketException(e.toString());
    }
  }
}

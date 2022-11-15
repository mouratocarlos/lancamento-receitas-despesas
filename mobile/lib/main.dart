import 'package:flutter/material.dart';
import 'package:lancamentos_receitas_despesas/models/dtos/movimentacao_financeira_dto.dart';
import 'package:lancamentos_receitas_despesas/models/entities/lista_sistema_entity.dart';
import 'package:lancamentos_receitas_despesas/services/lista_sistema_service.dart';
import 'package:lancamentos_receitas_despesas/services/movimentacao_financeira_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lançamentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lançamentos de Receitas e Despesas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ListaSistemaEntity> _formasBaixa;
  late List<ListaSistemaEntity> _especies;
  late List<MovimentacaoFinanceiraDto> _lancamentos;

  ListaSistemaService listaSistemaService = ListaSistemaService();
  MovimentacaoFinanceiraService movimentacaoFinanceiraService =
      MovimentacaoFinanceiraService();

  void initializate() async {
    _formasBaixa = await listaSistemaService.recuperarFormasBaixa();
    _especies = await listaSistemaService.recuperarEspecies();

    listarLancamentos();
  }

  void listarLancamentos() async {
    _lancamentos = await movimentacaoFinanceiraService
        .recuperarMovimentacoes("2022-12-08T00:00:00.00");
  }

  @override
  Widget build(BuildContext context) {
    initializate();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const <Widget>[
          ListTile(
            title: Text("Battery Full"),
            leading: Icon(Icons.battery_full),
          ),
          ListTile(
            title: Text("Anchor"),
            leading: Icon(Icons.anchor),
          ),
          ListTile(
            title: Text("Alarm"),
            leading: Icon(Icons.access_alarm),
          ),
          ListTile(
            title: Text("Ballot"),
            leading: Icon(Icons.ballot),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: listarLancamentos,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

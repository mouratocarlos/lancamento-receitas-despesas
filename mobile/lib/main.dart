import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lancamentos_receitas_despesas/models/dtos/movimentacao_financeira_dto.dart';
import 'package:lancamentos_receitas_despesas/models/entities/lista_sistema_entity.dart';
import 'package:lancamentos_receitas_despesas/models/entities/movimentacao_financeira_entity.dart';
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
      home: const MyHomePage(title: 'Lançamentos'),
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
  List<ListaSistemaEntity>? _formasBaixa;
  List<ListaSistemaEntity>? _especies;
  List<MovimentacaoFinanceiraDto> _lancamentos =
      List<MovimentacaoFinanceiraDto>.empty();

  DateTime date = DateTime.now();

  ListaSistemaService listaSistemaService = ListaSistemaService();
  MovimentacaoFinanceiraService movimentacaoFinanceiraService =
      MovimentacaoFinanceiraService();

  void _initializate() async {
    _formasBaixa = await listaSistemaService.recuperarFormasBaixa();
    _especies = await listaSistemaService.recuperarEspecies();
    await _listarLancamentos();
  }

  Future<void> _listarLancamentos() async {
    _lancamentos = await movimentacaoFinanceiraService
        .recuperarMovimentacoes(date.toIso8601String())
        .whenComplete(
          () => {
            setState(() {}),
          },
        );
  }

  void _openDialogCadastro(
      BuildContext context, MovimentacaoFinanceiraDto lancamento) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cadastro'),
        content: Container(
          height: 300,
          width: 300,
          child: ListView(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Id'),
                controller: TextEditingController(
                    text: lancamento.id > 0 ? lancamento.id.toString() : null),
                enabled: false,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Valor', hintText: 'Digite o Valor'),
                controller: TextEditingController(
                    text: lancamento.valor > 0
                        ? lancamento.valor.toString()
                        : null),
                autofocus: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: ((value) =>
                    {lancamento.valor = double.parse(value)}),
              ),
              TextField(
                maxLength: 200,
                decoration: const InputDecoration(
                    labelText: 'Observação', hintText: 'Digite a Observação'),
                controller: TextEditingController(text: lancamento.observacao),
                onChanged: ((value) => {lancamento.observacao = value}),
              ),
              DropdownButtonFormField(
                value: lancamento.listaFormaBaixa > 0
                    ? lancamento.listaFormaBaixa
                    : null,
                decoration: const InputDecoration(
                    labelText: 'Forma de Baixa', hintText: 'Selecione'),
                items: _formasBaixa!.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.descricao),
                  );
                }).toList(),
                onChanged: ((value) =>
                    {lancamento.listaFormaBaixa = value ?? 0}),
              ),
              DropdownButtonFormField(
                value: lancamento.listaTipoEspecie > 0
                    ? lancamento.listaTipoEspecie
                    : null,
                decoration: const InputDecoration(
                    labelText: 'Espécie', hintText: 'Selecione'),
                items: _especies!.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.descricao),
                  );
                }).toList(),
                onChanged: ((value) =>
                    {lancamento.listaTipoEspecie = value ?? 0}),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Gravar'),
            onPressed: () async {
              await _postItem(
                context,
                MovimentacaoFinanceiraEntity(
                  id: lancamento.id,
                  data: lancamento.data,
                  valor: lancamento.valor,
                  listaFormaBaixa: lancamento.listaFormaBaixa,
                  listaTipoEspecie: lancamento.listaTipoEspecie,
                  observacao: lancamento.observacao,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context, int id) async {
    await movimentacaoFinanceiraService.delete(context, id).whenComplete(() => {
          setState(() {}),
        });
  }

  Future<void> _postItem(
      BuildContext context, MovimentacaoFinanceiraEntity entity) async {
    await movimentacaoFinanceiraService
        .post(context, entity)
        .whenComplete(() => {
              setState(() {
                _listarLancamentos();
              }),
            });
  }

  @override
  void initState() {
    super.initState();

    _initializate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () => _listarLancamentos(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: _lancamentos.length,
            itemBuilder: (_, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _lancamentos.elementAt(index).valor.toStringAsFixed(2),
                ),
                const Spacer(),
                Text(
                  _lancamentos.elementAt(index).formaBaixa,
                ),
                const Spacer(),
                Text(
                  _lancamentos.elementAt(index).tipoEspecie,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _openDialogCadastro(context, _lancamentos.elementAt(index));
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.blueAccent,
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.check_box),
                                title: const Text(
                                  'Confirma excluir o registro?',
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _deleteItem(context,
                                          _lancamentos.elementAt(index).id)
                                      .whenComplete(() {
                                    setState(() {
                                      _listarLancamentos();
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (newDate == null) return;

          setState(() {
            date = newDate;
          });

          _listarLancamentos();
        },
        child: Text("${date.day}/${date.month}/${date.year}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openDialogCadastro(
          context,
          MovimentacaoFinanceiraDto(
            id: 0,
            data: date.toIso8601String(),
            valor: 0,
            listaFormaBaixa: 0,
            listaTipoEspecie: 0,
            formaBaixa: '',
            tipoEspecie: '',
            observacao: '',
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

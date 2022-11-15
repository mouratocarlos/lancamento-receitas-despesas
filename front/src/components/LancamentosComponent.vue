<template>
  <div class="body">
    <h1>{{ msg }}</h1>

    <div class="pesquisa-data">
      <input type="date" name="data" id="dataPesquisa" v-on:change="changeData($event)">
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNovo" v-on:click="lancamentoSelecionado = {}">
        <i class="fa fa-lg fa-edit"></i>
      </button>
    </div>

    <ul id="lancamentos" class="lancamentos-movimentacao">
      <li v-for="lancamento in lancamentos" :key="lancamento.id" class="container lancamento">
        <div class="row">

          <div class="col-md-1">
            ID: {{lancamento.id}}
          </div>

          <div class="col-md-2">
            Valor: {{lancamento.valor}}
          </div>

          <div class="col-md-2">
            Tipo: {{lancamento.formaBaixa}}
          </div>

          <div class="col-md-2">
            Espécie: {{lancamento.tipoEspecie}}
          </div>

          <div class="col-md-4">
            Observação: {{lancamento.observacao}}
          </div>

          <div class="col-md-1 buttons">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNovo" v-on:click="lancamentoSelecionado = lancamento">
              <i class="fa fa-lg fa-edit"></i>
            </button>

            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modalDelete" v-on:click="lancamentoSelecionado = lancamento">
              <i class="fa fa-trash"></i>
            </button>
          </div>
        </div>
      </li>
    </ul>

    <div v-show="lancamentos.length === 0">
      Não há lançamentos nesse dia
    </div>
  </div>

  <!-- Modal Novo -->
  <div class="modal fade" id="modalNovo" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Cadastro de Movimentação</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body modal-novo">
          <label>
            <div>ID</div>
            <input type="text" name="id" id="idLancamentoSelecionado" v-model="lancamentoSelecionado.id" disabled>
          </label>

          <label>
            <div>Valor</div>
            <input type="number" name="valor" id="valorLancamentoSelecionado" v-model="lancamentoSelecionado.valor">
          </label>

          <label>
            <div>Observação</div>
            <input type="text" name="observacao" id="observacaoLancamentoSelecionado" v-model="lancamentoSelecionado.observacao">
          </label>

          <label>
            <div>Espécie</div>
            <select name="" id="" v-model="lancamentoSelecionado.listaTipoEspecie">
              <option v-for="especie in especies" :key="especie.id" class="container" :value="especie.id">
                {{ especie.descricao }}
              </option>            
            </select>
          </label>

          <label>
            <div>Forma Baixa</div>
            <select name="" id="" v-model="lancamentoSelecionado.listaFormaBaixa">
              <option v-for="formaDeBaixa in formasDeBaixa" :key="formaDeBaixa.id" class="container" :value="formaDeBaixa.id">
                {{ formaDeBaixa.descricao }}
              </option>            
            </select>
          </label>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-primary" v-on:click="cadastrarMovimentacao()" data-bs-dismiss="modal">Salvar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Delete -->
  <div class="modal fade" id="modalDelete" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Excluir Registro</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          Confirma excluir o registro?
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-primary" v-on:click="excluirRegistro()" data-bs-dismiss="modal">Excluir</button>
        </div>
      </div>
    </div>
  </div>
  
</template>

<script>
import axios from "axios";

export default {
  name: 'LancamentosComponent',
  props: {
    msg: String
  },
  data() {
    return {
      lancamentos: [],
      lancamentoSelecionado: {},
      especies: [],
      formasDeBaixa: [],
      changeData: function() {
        this.recuperarMovimentacoes();
      },
      cadastrarMovimentacao: function() {
        if (this.lancamentoSelecionado.data === undefined) {
          this.lancamentoSelecionado.data = document.getElementById('dataPesquisa').value.toLocaleString()+'T00:00:00.00';
        }

        axios.post("http://localhost:8090/movimentacao-financeira",
          {
            "id": this.lancamentoSelecionado.id,
            "data": this.lancamentoSelecionado.data,
            "listaFormaBaixa": this.lancamentoSelecionado.listaFormaBaixa,
            "listaTipoEspecie": this.lancamentoSelecionado.listaTipoEspecie,
            "valor": this.lancamentoSelecionado.valor,
            "observacao": this.lancamentoSelecionado.observacao
          },
        ).then(() => {
          alert('Operação realizada com sucesso!');
          this.recuperarMovimentacoes();
        }).catch((error) => {
          console.log(error);
          alert('Não foi possível realizar a operação.')
        });
      },
      excluirRegistro: function() {        
        axios.delete("http://localhost:8090/movimentacao-financeira",
          {data: this.lancamentoSelecionado},
        ).then(() => {
          alert('Registro Excluído com Sucesso!')
          this.recuperarMovimentacoes();
        }).catch((error) => {
          console.log(error);
          alert('Não foi possível excluir o registro.')
        });
      },
      recuperarMovimentacoes: function() {
        axios.get("http://localhost:8090/movimentacao-financeira", {
          params: {"data": document.getElementById('dataPesquisa').value.toLocaleString()+'T00:00:00.00'},
        }).then((res) => {
          this.lancamentos = res.data;
        }).catch((error) => {
          console.log(error);
        });
      },
      recuperarEspecies: function() {
        axios.get("http://localhost:8090/lista-sistema", {
          params: {"tipo": 'TIPO_ESPECIE'},
        }).then((res) => {
          this.especies = res.data;
        }).catch((error) => {
          console.log(error);
        });
      },
      recuperarFormasDeBaixa: function() {
        axios.get("http://localhost:8090/lista-sistema", {
          params: {"tipo": 'FORMA_BAIXA'},
        }).then((res) => {
          this.formasDeBaixa = res.data;
        }).catch((error) => {
          console.log(error);
        });
      },
    }
  },
  mounted () {
    Date.prototype.toDateInputValue = (function() {
      var local = new Date(this);
      local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
      return local.toJSON().slice(0,10);
    });

    document.getElementById('dataPesquisa').value = new Date().toDateInputValue();

    this.recuperarFormasDeBaixa();
    this.recuperarEspecies();
    this.recuperarMovimentacoes();
  }
}
</script>

<style scoped>
  .body{
    padding: 10px;
  }

  .pesquisa-data {
    padding-bottom: 10px;
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    border-bottom: #012030 solid 2px;
  }

  ul {
    list-style-type: none;
    padding: 0px;
    max-height: 70vh;
    overflow: scroll;
  }

  li {
    text-align: start;
  }

  .lancamento {
    padding: 5px;
    border-bottom: #012030 solid 2px;
    border-left: #012030 solid 2px;
    border-right: #012030 solid 2px;
  }

  .lancamento .row {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .buttons {
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
  }

  .buttons button{
    margin-left: 10px;
  }

  .modal-novo {
    display: flex;
    flex-direction: column;    
  }

  .modal-novo label {
    display: flex;
    margin-bottom: 10px
  }

  .modal-novo input, .modal-novo select {
    margin-left: 10px;
    width: 100%;
    height: 100%;
    max-width: 200px;
  }

  .modal-novo label div {
    width: 170px;
    text-align: start;
  }

</style>

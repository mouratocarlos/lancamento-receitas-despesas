<template>
  <div class="body">
    <h1>{{ msg }}</h1>

    <div class="pesquisa-data">
      <input type="date" name="data" id="dataPesquisa" v-on:change="changeData($event)">
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
        <i class="fa fa-lg fa-edit"></i>
      </button>
    </div>

    <ul id="lancamentos">
      <li v-for="lancamento in lancamentos" :key="lancamento.id" class="container">
        <div class="row lancamento">

          <div class="id-lancamento col-md-1">
            ID: {{lancamento.id}}
          </div>

          <div class="valor-lancamento col-md-2">
            Valor: {{lancamento.valor}}
          </div>

          <div class="forma-baixa-lancamento col-md-2">
            Tipo: {{lancamento.formaBaixa}}
          </div>

          <div class="forma-especie-lancamento col-md-2">
            Espécie: {{lancamento.tipoEspecie}}
          </div>

          <div class="observacao-lancamento col-md-3">
            Observação: {{lancamento.observacao}}
          </div>

          <div class="id-lancamento col-md-1">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <i class="fa fa-lg fa-edit"></i>
            </button>
          </div>

          <div class="id-lancamento col-md-1">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
  <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          ...
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
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
    msg: String,
    dataSelicionada: String
  },
  data() {
    return {
      lancamentos: [],
      especies: [],
      formasDeBaixa: [],
      changeData: function() {
        this.recuperarMovimentacoes();
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
    display: flex;
    flex-direction: row;
    border-bottom: #012030 solid 2px;
    border-left: #012030 solid 2px;
    border-right: #012030 solid 2px;
    justify-content: space-between;
  }
</style>

<template>
  <div class="layout">
    <md-table md-card v-if="currency_list.length">
      <md-table-toolbar>
        <h1 class="md-title">Currency Rate updated at {{updated_date}}</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head class="center">Country</md-table-head>
        <md-table-head class="center">Target == Base</md-table-head>
        <md-table-head class="center">Base == Target</md-table-head>
        <md-table-head class="center">Date</md-table-head>
      </md-table-row>

      <md-table-row v-for="item in currency_list" :key="item.baseCurrency">
        <md-table-cell> {{item.baseCurrency}} </md-table-cell>
        <md-table-cell> {{item.targetUnit}}&nbsp;{{item.targetCurrency}}&nbsp;=&nbsp;{{item.baseValue}} </md-table-cell>
        <md-table-cell> {{item.baseUnit}}&nbsp;{{item.baseCurrency}}&nbsp;=&nbsp;{{item.targetValue}} </md-table-cell>
        <md-table-cell> {{item.date}} </md-table-cell>
      </md-table-row>

    </md-table>
    <div md-card v-if="!currency_list.length" class="waiting">
      <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate"></md-progress-spinner>
      <p>Waiting update from server ...</p>
    </div>
  </div>
</template>

<script>
  import socket from '../assets/js/bnm_socket'

  let channel = socket.channel("bnm:lobby", {})
    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

    // channel.on('currency_update', payload => {
    //   console.log(payload);
    //   currency_update = payload.payload.data;
    // });

  export default {
    name: 'CurrencyList',
    data: function() {
          return {
              currency_list: [],
              updated_date: ""
          }
        },
    created: function() {
          channel.on('currency_update', payload => {
            console.log('Received : ', payload);
            this.currency_list = [];
            this.currency_list = payload.payload.data;
            this.updated_date = new Date();
          });
        }
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .layout {
    padding: 10px;
  }
  .center {
    text-align: center;
  }
  .waiting{
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>

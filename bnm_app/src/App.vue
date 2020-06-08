<template>
  <div id="app">
    <img alt="Bnm logo" src="@/assets/bnm.png" class="logo">
    <CurrencyList></CurrencyList>
  </div>
</template>

<script>
import CurrencyList from './components/CurrencyList.vue'

export default {
  name: 'App',
  components: {
    CurrencyList
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.logo {
  padding-top: 10px;
  width: 70%;
}
</style>

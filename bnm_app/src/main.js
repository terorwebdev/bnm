import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false

import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'

import './assets/phoenix/phoenix';
import './assets/js/bnm_socket';

Vue.use(VueMaterial)

new Vue({
    render: h => h(App),
}).$mount('#app')
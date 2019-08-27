
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');



import VueRouter from 'vue-router'
import VeeValidate from 'vee-validate'
import vSelect from 'vue-select'
import {default as adminRoute} from './routes/adminRoute'
import VueSweetalert2 from 'vue-sweetalert2';
import Vue2Filters from 'vue2-filters'
import datePicker from 'vue-bootstrap-datetimepicker';
import timePicker from 'vue-bootstrap-datetimepicker';
import moment from 'moment';




Vue.use(datePicker);
Vue.use(timePicker);
Vue.use(Vue2Filters)
Vue.use(VueRouter)
Vue.use(VeeValidate)
Vue.use(VueSweetalert2);
Vue.use(require('vue-moment'));
Vue.use(moment)



let routeList=[]
const routes=routeList.concat(
    adminRoute
)

const router= new VueRouter({
    routes,
    mode: 'history'
})
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('example-component', require('./components/ExampleComponent.vue'));
Vue.component('admin-header', require('./components/adminPartial/adminHeader'));
Vue.component('admin-sidebar', require('./components/adminPartial/sidebar'));
Vue.component('main-content', require('./components/adminPartial/mainContent'));
Vue.component('admin-home', require('../../resources/js/admin/home'));
Vue.component('v-select', vSelect);
Vue.component('data-table', require('./components/global/DataTable.vue'))
Vue.component('data-table-ledger', require('./components/global/DataTableLedger.vue'))
Vue.component('data-table-day-book', require('./components/global/DataTableDayBook.vue'))
Vue.component('data-table-other-ledger', require('./components/global/DataTableOtherLedger.vue'))
Vue.component('data-table-regular-form', require('./components/global/datTableRegularForm.vue'))
Vue.component('regular-create-form', require('./admin/views/regular/regularCreateFrom.vue'))
Vue.component('regular-edit-form', require('./admin/views/regular/regularEditForm.vue'))


 new Vue({
    el: '#app',
    router,
     data:{
         accounts:[],
         user:null,
         company:null,
     },
     created(){
        this.getAccounts()
         this.getUser()
     },
     methods:{
         getAccounts(){
                axios.get('/account-list').then(res=>{
                    this.accounts=res.data
                })
            },
         confirmationDelete(){
             return new Promise((resolve, reject)=>{
                 this.$swal({
                     title: 'Confirm?',
                     // text: "You won't be able to revert this!",
                     showCancelButton: true,
                     confirmButtonColor: 'green',
                     cancelButtonColor: '#c60005',
                     confirmButtonText: 'Yes',
                     cancelButtonText: "No",
                     animation: false
                 }).then((result) => {
                     if (result.value) {
                         resolve(result.value)
                     }
                 })
             })
         },
         getUser(){
             axios.get('/get-loggedin-user').then(res=>{
                 this.user=res.data.user
                 this.company=res.data.company

             })
         },
         parseDateISO(val){
             var spliceDate = val.slice(0,10)
                 const [day, month, year] =spliceDate.split('-')
             return year+'-'+month+'-'+day
         },
         downloadExcel(tableId){
             var tableSelect = document.getElementById(tableId);
             console.log(tableSelect)
             var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

             var path = 'data:application/vnd.ms-excel,' +tableHTML;
             window.open(path);
         }
     }
});

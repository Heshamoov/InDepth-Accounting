<template>
    <div>
        <div class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
            <div class="row be-datatable-header card-header">
                <div class="col-md-12 d-flex justify-content-between  flex-wrap" id="adjustHeader">
                    <div class="d-flex align-items-center justify-content-start">
                        <div class="cateTitle"> <i class="far fa-list-alt"></i> -  {{tableHeadline}} </div>
                    </div>
                    <div class="response_flex">
                        <div class="search-container mr-2" v-if="search">
                            <date-picker
                                    v-model="from_date"
                                    :config="dateOptions"
                                    @input="searched=false"

                            >
                            </date-picker>

                        </div>
                        <div class="search-container mr-2" v-if="search">
                            <date-picker
                                    v-model="to_date"
                                    :config="dateOptions"
                                    @input="searched=false"

                            >
                            </date-picker>

                        </div>
                        <div class="search-container mr-2" v-if="search">
                            <button @click.prevent="assainSearchValue(),searched=true">Search</button>

                        </div>
                        <div class="search-container mr-2" v-if="search">
                            <input type="text" v-model="searchValue" placeholder="Search.." @keyup="getResult(null,dateSearchFieldName,from_date,to_date)">
                            <i class="fa fa-search searchIcon"></i>
                        </div>
                        <div class="printableArea" >
                            <router-link :to="{name:addLink}" class="headerIcon pt-1 pb-1">
                                <i class="fa fa-plus-circle" v-if="addButton"></i>
                            </router-link>
                            <a href="" @click.prvent="printMe()" class="headerIcon pt-1 pb-1">
                                <i class="fa fa-print"></i>
                            </a>
                            <a href="" class="headerIcon pt-1 pb-1" @click.prevent="$root.downloadExcel('table1')">
                                <i class="fa fa-file-excel-o"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row be-datatable-body" v-if="dataList.length">
                <div class="col-md-12  mt-2 mb-2" style="overflow-x: auto;" id="section-to-print">
                    <div id="tableTop" style="display: none">
                        <h2 class="text-center" v-if="$root.$data.company">{{$root.$data.company.name}}</h2>
                        <h4 class="text-center">{{tableHeadline}}</h4>
                        <span style="display: flex; justify-content: center">FOR THE PERIOD
                                 <template v-if="from_date && to_date && searched">
                                        <strong>{{$root.parseDateISO(from_date) | moment("DD MMMM, YYYY")}}</strong>  To <strong>{{$root.parseDateISO(to_date) | moment("DD MMMM, YYYY")}}</strong>
                                 </template>
                                     <template v-else>
                                           (All Data From Starting to End)
                                     </template>

                             </span>
                        <template v-if="$root.$data.company">
                            <p>Contact: {{$root.$data.company.mobile}}</p>
                            <p>Address: {{$root.$data.company.address}}</p>
                        </template>
                    </div>
                    <table class="table table-striped  table-fw-widget dataTable no-footer table_block ledger" id="table1"
                           role="grid" aria-describedby="table1_info">
                        <thead>
                        <tr role="row">
                            <th v-for="(column, index) in columns" class="sorting text-center"
                                tabindex="0"
                                rowspan="1"
                                colspan="1"
                                :id="column.field"
                                @click="onClickColumn">
                                {{column.name}}
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                        <tr v-for="data in dataList">
                            <slot name="items" v-bind:data="data">
                            </slot>
                        </tr>
                        </tbody>

                    </table>
                </div>
            </div>
            <div class="center-screen" v-else>

            </div>
            <div class="footer table__footer">
                <div class="bottomAdjust">
                    <div>
                        <div class="dataTables_length">
                            <label>Show
                                <select style="text-align-last: center; height: 24px;" name="table1_length" id="resultPerPage"
                                        aria-controls="table1"
                                        class="form-control form-control-sm customShown" @change="onChangePerPage">
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="200">200</option>
                                    <option value="All">All</option>
                                </select> Entries &nbsp;</label>
                        </div>
                    </div>
                    <div>
                        <div class="dataTables_info" id="table1_info" role="status" aria-live="polite"> ( Showing {{from}} to
                            {{to}}
                            of {{total}} )
                        </div>
                    </div>
                </div>
                <div class="bottom_pagination">
                    <div class="dataTables_paginate paging_simple_numbers mt-1" v-if="paging">
                        <ul class="pagination">
                            <li :class="{'paginate_button': true, 'page-item':true, 'previous':true, 'disabled':(current_page === 1)}"
                                id="table1_previous">
                                <a tabindex="0" class="page-link" @click="getResult(current_page - 1)">Previous</a>
                            </li>
                            <template v-for="page in last_page">
                                <li :class="{'paginate_button': true, 'page-item':true, 'active':(page === current_page)}"
                                    v-if="Math.abs(page - current_page) < 3">
                                    <a tabindex="0" class="page-link" @click="getResult(page)">{{page}}</a>
                                </li>
                            </template>
                            <li :class="{'paginate_button': true, 'page-item':true, 'next':true, 'disabled':(current_page === last_page)}"
                                id="table1_next">
                                <a tabindex="0" class="page-link" @click="getResult(current_page + 1)">Next</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row be-datatable-footer">
                <!--<div class="col-sm-5 d-flex align-items-center flex-wrap" id="bottomAdjust">-->
                <!---->
                <!---->
                <!--</div>-->
                <div class="col-sm-7" id="adjustPagination">

                </div>
            </div>
        </div>


    </div>
</template>

<script>
    export default {

        props: {


            data: {
                type: Array,
                default: () => []
            },
            columns: {
                type: Array,
                default: () => []
            },
            ajax: {
                type: Object,
                default: () => {
                }
            },
            paging: {
                type: Boolean,
                default: () => true
            },
            scrollX: {
                type: Boolean,
                default: () => false
            },
            scrollY: {
                type: Boolean,
                default: () => false
            },
            select: {
                type: Boolean,
                default: () => false
            },
            search: {
                type: Boolean,
                default: () => false
            },
            sorting: {
                type: Boolean,
                default: () => true
            },
            addLink: {
                type: String,
                default: () => ''
            },
            tableHeadline:{
                type:String,
                default:()=>''
            },
            searchField:{
                type:String,
                default:()=>''
            }
            ,
            addButton:{
                type:Boolean,
                default:()=>true
            },
            userAddButton:{
                type:Boolean,
                default:()=>false
            },
            dateSearchFieldName:{
                type:String,
                default:()=>''
            }


        },
        data() {
            return {
                dataList: [],
                searched:false,
                reverseData:[],
                columnList: [],
                sortName: 'id',
                sortOrder: 'desc',
                current_page: 1,
                last_page: 0,
                per_page: 0,
                total: 0,
                path: '',
                from: 0,
                to: 0,
                pageLimit: 10,
                resultPerPage: 10,
                searchValue:null,
                dateOptions: {
                    format: 'DD-MM-YYYY',
                    useCurrent: true,
                },
                from_date:null,
                to_date:null,
            }
        },
        watch:{
            ajax:function(newVal) {
                this.getDataList()
            }

        },
        created(){
            this.getDataList()

        },
        methods: {

            getDataList(){
                if (_.isEmpty(this.ajax)) {
                    this.dataList = this.data
                } else {
                    this.getResult()
                }
            },
            onClickColumn(e) {
                if (this.sorting) {

                    let sortname = $(e.target).text().trim().toLowerCase().replace(' ', '_')

                    this.sortName = sortname != 'action' ? sortname : 'id'
//                    this.sortName = e.target.id
                    if (e.target.classList[0] === 'sorting') {
                        e.target.classList.remove('sorting')
                        e.target.classList.add('sorting_asc')
                        this.sortOrder = 'asc'
                    } else if (e.target.classList[0] === 'sorting_asc') {
                        e.target.classList.remove('sorting_asc')
                        e.target.classList.add('sorting_desc')
                        this.sortOrder = 'desc'
                    } else if (e.target.classList[0] === 'sorting_desc') {
                        e.target.classList.remove('sorting_desc')
                        e.target.classList.add('sorting_asc')
                        this.sortOrder = 'asc'
                    }
                    this.removeAllSorting(e.target.parentElement.childNodes, e)
                    this.getResult()
                }
            },
            removeAllSorting(childList, e) {
                for (var i = 0; i < childList.length; i++) {
                    if (childList[i].id === e.target.id) continue
                    childList[i].classList.remove('sorting_asc')
                    childList[i].classList.remove('sorting_desc')
                    childList[i].classList.add('sorting')
                }
            },
            getResult(page = 1,serachFied,fromDate,toDate) {
                this.current_page = page
                if (!_.isEmpty(this.ajax)) {
                    axios.get(this.ajax.url, {
                        params: {
                            sortName: this.sortName=='status'?'is_active':this.sortName,
                            sortOrder: this.sortOrder,
                            paging: this.paging,
                            page: page,
                            resultPerPage: this.resultPerPage,
                            searchKey: this.searchField,
                            searchValue: this.searchValue,
                            fromDate: fromDate,
                            toDate: toDate,
                            fieldName: serachFied,
                        }
                    }).then(response => {
                        if (this.paging) {
                            this.dataList = response.data.data
                            this.reverseData = (response.data.data).slice().reverse()
                            var totalAmount=response.data.previous_balance
                            var i=1
                            this.reverseData.forEach(value=>{
                                if(value.amount){
                                    var amount=Number(value.amount)
                                    if(value.payment_type=="Prepaid Expense"){
                                        value.type=="prepaid expense"?
                                            totalAmount = totalAmount + amount:
                                            totalAmount = totalAmount - amount

                                    }else if(value.payment_type=="Adjust"){

                                        value.come_from=="asset"?
                                            totalAmount = totalAmount - amount:
                                            totalAmount = totalAmount + amount
                                    }
                                    else{

                                        totalAmount = totalAmount + amount

                                    }
                                    this.dataList[this.dataList.length-i]['total_amount']=totalAmount
                                    i++
                                }
                            })
                            this.dataList[this.dataList.length]={account_id: null,amount:null,date: 'balance',description: "Previous Balance",id: null,payment_type: ""
                                ,ref: "",type: "",total_amount:response.data.previous_balance}
                            this.current_page = response.data.current_page
                            this.last_page = response.data.last_page
                            this.per_page = response.data.per_page
                            this.total = response.data.total
                            this.path = response.data.path
                            this.from = response.data.from
                            this.to = response.data.to
                        } else {
                            this.dataList = response.data
                        }
                    });

                }
            },
            onChangePerPage() {
                this.resultPerPage = document.getElementById('resultPerPage').value;
                this.getResult()
            },
            assainSearchValue(){
                this.getResult(null,this.dateSearchFieldName,this.from_date,this.to_date)
            },
            printMe(){
                window.print()
            },
        }
    }
</script>

<style scoped>

    .btn{
        line-height: 25px;
    }

</style>

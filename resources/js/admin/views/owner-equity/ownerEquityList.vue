<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'ownerEquityCreate'"
                :tableHeadline="'Owner Equity Transactions'"
                :searchField="'account'"
                :dateSearch="true"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">

                    {{props.data.account}}

                </td>
                <td class="text-center">

                    {{props.data.ref}}

                </td >
                <td class="text-center">

                    {{props.data.description}}

                </td>
                <td class="text-center">

                    {{props.data.payment_type}}{{props.data.account_receivable?' - '+props.data.account_receivable.name:null}}

                </td>
                <td class="text-center">

                    {{props.data.amount|currency('£')}}

                </td>

                <td>
                    <div class="adjustAction">
                        <template v-if="$root.$data.user.role=='admin'">
                        <router-link :to="{name:'ownerEquityEdit', params:{id:props.data.id}}">
                            <i class="fa fa-edit"></i>
                        </router-link>

                        <a @click.prevent="deleteMe(props.data.id)" href="#">
                            <i class="fa fa-trash"></i>
                        </a>
                        </template>
                    </div>
                </td>
            </template>
        </data-table>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                url:'/owner-equity',
                columns: [
                    {name: 'Account'},
                    {name: 'Ref'},
                    {name: 'Description'},
                    {name: 'Payment Type'},
                    {name: 'Amount'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/owner-equity/' + id).then(response => {
                            var dataTable = this.$refs.dataTable
                            dataTable.getResult();
                            this.$swal({
                                type: response.data.message.type,
                                title: response.data.message.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                        });
                    }
                });
            }
        }

    }
</script>

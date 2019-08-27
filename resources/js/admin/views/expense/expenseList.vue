<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'expenseCreate'"
                :tableHeadline="'Expense List'"
                :searchField="'account.name'"
                :dateSearch="true"
                :dateSearchFieldName="'expense_date'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">

                    {{props.data.account.name}}

                </td>
                <td class="text-center">

                    {{props.data.ref}}

                </td >
                    <td class="text-center">

                    {{props.data.description}}

                </td>
                <td class="text-center">

                    {{props.data.payment_type }}{{props.data.modelable?' - '+props.data.modelable.name:null}}

                </td>
                <td class="text-center">

                    {{props.data.amount|currency('£')}}

                </td>
                <td class="text-center">

                    {{props.data.tax_rate?props.data.tax_rate+'%':'0%'}}

                </td>
                <td class="text-center">

                    {{props.data.tax_amount|currency('£')}}

                </td>
                <td class="text-center">

                    {{props.data.after_tax_amount|currency('£')}}

                </td>

                <td class="text-center">
                    <div class="adjustAction">
                        <template v-if="$root.$data.user.role=='admin'">
                            <router-link :to="{name:'expenseEdit', params:{id:props.data.id}}">
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
                url:'/expense',
                columns: [
                    {name: 'Account'},
                    {name: 'Ref'},
                    {name: 'Description'},
                    {name: 'Payment Type'},
                    {name: 'Amount'},
                    {name: 'VAT Rate'},
                    {name: 'VAT Amount'},
                    {name: 'Total Amount'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/expense/' + id).then(response => {
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

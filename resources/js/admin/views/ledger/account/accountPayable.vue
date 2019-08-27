<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addButton="false"
                :tableHeadline="'Ledger of Account Payable'"
                :searchField="'name'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">
                    <router-link :to="{name:'ledgerOtherShow', params:{id:props.data.id,type:props.data.account_type,name:props.data.name}}">
                        {{props.data.name}}
                    </router-link>

                </td>

            </template>
        </data-table>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                url:'/ledger/accounts/account-payable',
                columns: [
                    {name: 'Name'},

                ]
            }
        },

        methods:{

        }

    }
</script>

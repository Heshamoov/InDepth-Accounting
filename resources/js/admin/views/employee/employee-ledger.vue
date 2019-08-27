<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addButton="false"
                :tableHeadline="'Ledger of Employee'"
                :searchField="'name'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">
                    <router-link :to="{name:'ledgerOtherShow', params:{id:props.data.id,type:'Employee',name:props.data.name}}">
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
                url:'/ledger/employee-ledger',
                columns: [
                    {name: 'Name'},

                ]
            }
        },

        methods:{

        }

    }
</script>

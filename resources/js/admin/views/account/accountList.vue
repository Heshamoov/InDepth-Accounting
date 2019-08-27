<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'accountCreate'"
                :tableHeadline="'Account List'"
                :searchField="'name'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">

                    {{props.data.name}}

                </td>
                <td class="text-center">

                    {{props.data.account_type}}

                </td>
                <td class="text-center">
                    {{props.data.description}}
                </td>
                <td class="text-center">
                    <div class="adjustAction">
                        <template v-if="$root.$data.user.role=='admin'">
                        <router-link :to="{name:'accountEdit', params:{id:props.data.id}}">
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
                url:'/account',
                columns: [
                    {name: 'Name'},
                    {name: 'Account Type'},
                    {name: 'Description'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/account/' + id).then(response => {
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

<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'userCreate'"
                :tableHeadline="'User List'"
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

                    {{props.data.email}}

                </td>
                <td class="text-center">
                    {{props.data.role}}
                </td>
                <td class="text-center">
                    <div class="adjustAction">
                        <router-link :to="{name:'userEdit', params:{id:props.data.id}}">
                            <i class="fa fa-edit"></i>
                        </router-link>
                        <template v-if="props.data.role!='admin'">
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
                url:'/user-info',
                columns: [
                    {name: 'Name'},
                    {name: 'Email'},
                    {name: 'Role'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/user-info/' + id).then(response => {
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

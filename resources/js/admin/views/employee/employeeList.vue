<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'employeeCreate'"
                :tableHeadline="'Employee List'"
                :searchField="'name'"
                :dateSearchFieldName="'start_date'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">

                  {{props.data.name}}

                </td>
                <td class="text-center">
                    {{props.data.id_card}}
                </td>
                <td class="text-center">
                    {{props.data.phone}}
                </td>
                <td class="text-center">
                    {{props.data.email}}
                </td>
                <td class="text-center">
                    {{props.data.address}}
                </td>
                <td class="text-center">

                    <div class="adjustAction">
                        <template v-if="$root.$data.user.role=='admin'">
                        <router-link :to="{name:'employeeEdit', params:{id:props.data.id}}">
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
                url:'/employee',
                columns: [
                    {name: 'Name'},
                    {name: 'Id No'},
                    {name: 'Phone'},
                    {name: 'Email'},
                    {name: 'Address'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/employee/' + id).then(response => {
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

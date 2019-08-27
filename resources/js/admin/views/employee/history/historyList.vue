<template>
    <div class="card card-table">
        <data-table
                ref="dataTable"
                :search="true"
                :columns="columns"
                :addLink="'employeeHistoryCreate'"
                :tableHeadline="'Employee History List'"
                :searchField="'employee.name'"
                :dateSearch="true"
                :dateSearchFieldName="'start_date'"
                :ajax="{
                            url: url
                        }"
        >
            <template slot="items" slot-scope="props">

                <td class="text-center">

                    {{props.data.employee.name}}

                </td>
                <td class="text-center">
                    {{props.data.start_date}}
                </td>
                <td class="text-center">
                    {{props.data.end_date}}
                </td>
                <td class="text-center">
                    {{$refs.dataTable.getHoursAndMinute(props.data.start_date,props.data.end_date)}}
                </td>
                <td class="text-center">
                    <div class="adjustAction">
                        <template v-if="$root.$data.user.role=='admin'">
                        <router-link :to="{name:'employeeHistoryEdit', params:{id:props.data.id}}">
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
                url:'/employee/history',
                columns: [
                    {name: 'Name'},
                    {name: 'Start Time'},
                    {name: 'End Time'},
                    {name: 'Work Time'},
                    {name: 'Action'},
                ]
            }
        },

        methods:{

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/employee/history/' + id).then(response => {
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

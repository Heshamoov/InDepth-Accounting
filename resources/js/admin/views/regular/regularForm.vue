<template>
	<div class="card card-table">
		<data-table-regular-form
				ref="dataTable"
				:search="true"
				:columns="columns"
				:tableHeadline="'Day Sales List'"
				:searchField="'name'"
				:dateSearch="true"
				:dateSearchFieldName="'date'"
				:ajax="{
                            url: url
                        }"
		>
			<template slot="items" slot-scope="props">
				
				
				<td class="text-center">
					
					{{parseDate(props.data.date)}}
				
				</td>
				<td class="text-center">
					{{props.data.name}}
				</td>
				<td class="text-center">
					{{props.data.agt}}
				</td>
				<td class="text-center">
					{{props.data.ref}}
				</td>
				<td class="text-right">
					{{props.data.cash}}
				</td>
				<td class="text-right">
					{{props.data.bank}}
				</td>
				<td class="text-right">
					{{props.data.eviivo}}
				</td>
				<td class="text-right">
					{{props.data.rm_total}}
				</td>
				<td class="text-center">
					{{props.data.parking_cash}}
				</td>
				<td class="text-right">
					{{props.data.parking_card}}
				</td>
				<td class="text-right">
					{{props.data.other_sales}}
				</td>
				<td class="text-right">
					{{props.data.return}}
				</td>
				<td class="text-right">
					{{props.data.advance_sales}}
				</td>
				<td class="text-center">
					{{props.data.remark}}
				</td>
				<td class="text-center">
					<div class="adjustAction" v-if="props.data.id!='balance'">
						<template>
						<a href="" @click.prevent="callEditModal(true),passIdInModal(props.data.id)">
							<i class="fa fa-edit"></i>
						</a>
						
						<a @click.prevent="deleteMe(props.data.id)" href="#">
							<i class="fa fa-trash"></i>
						</a>
						</template>
					</div>
				</td>
			</template>
		</data-table-regular-form>
		<div v-if="callRegularForm" class="regularModal">
			<div class="container">
			<div class="row">
				<div class="col-md-9 bg-white mx-auto mt-5">
					<div class="modalHeader">
						<div class="title pt-3 pl-1">
							<h5 class="border p-2">Add Day Sales </h5>
						</div>
						<div @click.prevent="callRegularForm=false" class="cross"> <i class="fa fa-times" aria-hidden="true"></i> </div>
					</div>
					<div class="content">
						<regular-create-form></regular-create-form>
					</div>
				</div>
			</div>
			</div>
			
		</div>

		<div v-if="callRegularEditForm" class="regularModal">
			<div class="container">
				<div class="row">
					<div class="col-md-12 bg-white mx-auto mt-5">
						<div class="modalHeader">
							<div class="title pt-3 pl-1">
								<h3>Edit Day Sales  </h3>
							</div>
							<div @click.prevent="callRegularEditForm=false" class="cross"> <i class="fa fa-times" aria-hidden="true"></i> </div>
						</div>
						<div class="content">
							<regular-edit-form :id="id"></regular-edit-form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</template>

<script>
    export default {
        data() {
            return {
                callRegularForm:false,
                callRegularEditForm:false,
				id:null,

                url:'/regular-form',
                columns: [
                    {name: 'Date'},
                    {name: 'Name'},
                    {name: 'AGT'},
                    {name: 'Ref.'},
                    {name: 'Cash'},
                    {name: 'Bank'},
                    {name: 'Eviivo'},
                    {name: 'RM Total'},
                    {name: 'Cash'},
                    {name: 'Card'},
                    {name: 'Other Sales'},
                    {name: 'Sales Return'},
                    {name: 'Adv. Sales'},
                    {name: 'Remarks'},
                    {name: 'Action'},
                ],

            }
        },

        methods:{

            callModal(value){
                this.callRegularForm = value;
            },

            callEditModal(value){
                this.callRegularEditForm = value;
            },
            passIdInModal(val){
                this.id=val
			},

            deleteMe(id) {
                this.$root.confirmationDelete().then(val => {
                    if (val) {
                        axios.delete('/regular-form/' + id).then(response => {
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
            },
			parseDate(value){
                if(value!='Total-'){
                    var date=value.slice(0,10)
                    const [year,month,day]=date.split('-')
                    return day+'-'+month+'-'+year
				}

			}
        }

    }
</script>

<style scoped lang="scss">
	table.dataTable thead > tr > th.sorting {
		 padding-right: 0px!important;
	}
</style>

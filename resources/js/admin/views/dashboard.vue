<template>
	<div>
			<div class="app-title">
				<div class="p-3">
					<h1><i class="fa fa-dashboard"></i> Dashboard</h1>
				</div>
			</div>

<template v-if="$root.$data.user?$root.$data.user.role!='user':false">

			<div class=" d-flex flex-wrap justify-content-around">
				<div class=" accountsInfo ">
					<div>
						<i class="fa fa fa-calculator"></i>
					</div>
					<div>
						<h4>Total Sale </h4>
						<small>&nbsp;&nbsp;( <strong>Week = </strong>{{ weeklySales|currency('£')}} )</small>
						<br>
						<small>( <strong>Month = </strong>{{ monthlySales|currency('£')}} )</small>
					</div>
				</div>
				<div class=" accountsInfo ">
					<div>
						<i class="fa fa-bar-chart"></i>
					</div>
					<div>
						<h4>Total Expense </h4>
						<small>&nbsp;&nbsp;(  <strong> Week = </strong>{{ weeklyExpense|currency('£')}}  )</small>
						<br>
						<small>(  <strong>Month = </strong>{{ monthlyExpense|currency('£')}}  )</small>

					</div>
				</div>
				<div class=" accountsInfo ">
					<div>
						<i class="fa fa-pie-chart"></i>
					</div>
					<div>
						<h4>Total Cash </h4>
						<small>( <strong>{{cashAmount|currency('£')}}</strong>)</small>
					</div>
				</div>
				<div class=" accountsInfo ">
					<div>
						<i class="fa fa-area-chart"></i>
					</div>
					<div>
						<h4>Total Bank </h4>
						<small>( <strong>{{bankAmount|currency('£')}}</strong>)</small>
					</div>
				</div>

			</div>

</template>

	</div>
 
</template>

<script>
    export default {
        name: "dashboard",
		data(){
            return{
				monthlySales:0,
				weeklySales:0,
				monthlyExpenseData:[],
				weeklyExpenseData:[],
				cash:{},
				bank:{},

			}
		},
		created(){
			this.getData();
		},
		computed:{
		  	monthlyExpense:function () {
		  	    var amount=0;
				this.monthlyExpenseData.forEach(value=>{
                    amount= amount+Number(value.expenseAmount)-Number(value.expenseAssetAmount)
				})
				return amount.toFixed(2);
            },
            weeklyExpense:function () {
                var amount=0;
                this.weeklyExpenseData.forEach(value=>{
                    amount= amount+Number(value.expenseAmount)-Number(value.expenseAssetAmount)
                })
                return amount.toFixed(2);
            },
            cashAmount:function () {
                var amount = Number(this.cash?this.cash.assetCashAmount:0)-
                    Number(this.cash?this.cash.expenseAmount:0)+
                    Number(this.cash?this.cash.incomeAmount:0)+
                    Number(this.cash?this.cash.liabilityAmount:0)+
                    Number(this.cash?this.cash.initialCashAmount:0)+
                    Number(this.cash?this.cash.equityAmount:0)
                return amount.toFixed(2)
            },
            bankAmount:function () {
                var amount = Number(this.bank?this.bank.assetBankAmount:0)-
                    Number(this.bank?this.bank.expenseAmount:0)+
                    Number(this.bank?this.bank.incomeAmount:0)+
                    Number(this.bank?this.bank.liabilityAmount:0)+
                    Number(this.bank?this.bank.initialBankAmount:0)+
                    Number(this.bank?this.bank.equityAmount:0)
                return amount.toFixed(2)

            },

		},
		methods:{
			getData(){
                axios.get('/dashboard-data').then(res=>{
					this.weeklySales=res.data.weeklySales
					this.monthlySales=res.data.monthlySales
					this.monthlyExpenseData=res.data.monthlyExpenseData
					this.weeklyExpenseData=res.data.weeklyExpenseData
					this.cash=res.data.cash
					this.bank=res.data.bank
                })
			}
		}
    }
</script>

<style scoped>

</style>

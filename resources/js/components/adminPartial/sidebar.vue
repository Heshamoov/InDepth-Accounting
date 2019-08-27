<template>

 	<div v-if="is_loaded">

		<div class="app-sidebar__overlay" data-toggle="sidebar"></div>

		<aside class="app-sidebar">
			<!--<div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg" alt="User Image">-->
				<!--<div>-->
					<!--<p class="app-sidebar__user-name">John Doe</p>-->
					<!--<p class="app-sidebar__user-designation">Admin</p>-->
				<!--</div>-->
			<!--</div>-->

			<ul class="app-menu">


				<li>
					<router-link
							class="app-menu__item active"
							:to="{name:'dashboard'}">
				   	    <i class="app-menu__icon fa fa-tachometer"></i>
					    <span class="app-menu__label">Dashboard</span>
				    </router-link>
				</li>

<template v-if="$root.$data.user.role!='user'">

				<li class="treeview">
					<a class="app-menu__item" href=""  @click.prevent data-toggle="treeview">
					<i class="app-menu__icon fa fa-calculator"></i>
					<span class="app-menu__label">Accounts</span>
					<i class="treeview-indicator fa fa-angle-right"></i>
				</a>

					<ul class="treeview-menu">
						<li><router-link
								:to="{name:'accountCreate'}"
								class="treeview-item"
								href=""><i class="icon fa fa-dot-circle-o"></i> Add Account
						</router-link>
						</li>

						<li>
							<router-link
								:to="{name:'accountList'}"
								class="treeview-item"
								href=""><i class="icon fa fa-dot-circle-o"></i> Manage Account
						    </router-link>
						</li>

					</ul>
				</li>

				<li class="treeview">
					<a class="app-menu__item"
					   @click.prevent href=''
					   data-toggle="treeview">
						<i class="app-menu__icon fa fa-laptop"></i>
						<span class="app-menu__label">Employee</span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>

					<ul class="treeview-menu">
						<li>
							<router-link  :to="{name:'employeeCreate'}"
										  class="treeview-item">
								<i class="icon fa fa-dot-circle-o"></i> Add Employee
							</router-link>
						</li>

						<li><router-link :to="{name:'employeeList'}"
							class="treeview-item" >
							<i class="icon fa fa-dot-circle-o"></i> Manage Employee
						</router-link></li>

						<li><router-link
								:to="{name:'employeeHistoryCreate'}"
								class="treeview-item" >
							<i class="icon fa fa-dot-circle-o"></i>Add History
						</router-link></li>


						<li><router-link
								:to="{name:'employeeHistoryList'}"
								class="treeview-item" >
							<i class="icon fa fa-dot-circle-o">
							</i>Manage History</router-link>
						</li>

						<li><router-link
								:to="{name:'ledgerEmployeeShow'}"
								class="treeview-item" >
							<i class="icon fa fa-dot-circle-o"></i> Employee Ledger
						</router-link></li>
					</ul>
				</li>

				<li class="treeview">
					<a class="app-menu__item"
					   href="" @click.prevent data-toggle="treeview">
						<i class="app-menu__icon fa fa-edit"></i>
						<span class="app-menu__label">Expense</span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li><router-link
								:to="{name:'expenseCreate'}"
								class="treeview-item">
							<i class="icon fa fa-dot-circle-o"></i> Add Expense
							</router-link>
						</li>

						<li>
							<router-link
									:to="{name:'expenseList'}"
									class="treeview-item">
								<i class="icon fa fa-dot-circle-o"></i> Manage Expense
							</router-link>
						</li>

					</ul>
				</li>
				<li class="treeview"><a class="app-menu__item" href="" @click.prevent data-toggle="treeview"><i class="app-menu__icon fa fa-edit"></i><span class="app-menu__label">Sales & Income</span><i class="treeview-indicator fa fa-angle-right"></i></a>
					<ul class="treeview-menu">
						<li><router-link :to="{name:'incomeCreate'}" class="treeview-item" ><i class="icon fa fa-dot-circle-o"></i> Add </router-link></li>
						<li><router-link :to="{name:'incomeList'}" class="treeview-item"><i class="icon fa fa-dot-circle-o"></i> Manage </router-link></li>
					</ul>
				</li>
				<li class="treeview"><a class="app-menu__item" href="" @click.prevent data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span class="app-menu__label">Asset</span><i class="treeview-indicator fa fa-angle-right"></i></a>
					<ul class="treeview-menu">
						<li>
							<router-link
									:to="{name:'assetCreate'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i>Add Asset
							</router-link>
						</li>
						<li>
							<router-link
									:to="{name:'assetList'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i> Manage Asset
							</router-link>
						</li>
						<li>
							<router-link :to="{name:'ledgerAccountReceivableShow'}"
										 class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i> Receivable Ledger
							</router-link>
						</li>
						<li>
							<router-link :to="{name:'ledgerAccountFixedAsset'}"
										 class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i>Ledger
							</router-link>
						</li>
					</ul>
				</li>


				<li class="treeview">
					<a class="app-menu__item"
					   href="" @click.prevent
					   data-toggle="treeview">
						<i class="app-menu__icon fa fa-th-list"></i>
						<span class="app-menu__label">Liability </span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li>
							<router-link
									:to="{name:'liabilityCreate'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i>Add Liability
							</router-link>
						</li>

						<li>
							<router-link
									:to="{name:'liabilityList'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i> Manage Liability
							</router-link>
						</li>
						<li>
							<router-link
									:to="{name:'ledgerAccountPayableShow'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i> Payable Ledger
							</router-link>
						</li>
						<li>
							<router-link
									:to="{name:'ledgerAccountLiability'}"
									class="treeview-item" >
								<i class="icon fa fa-dot-circle-o"></i>Ledger
							</router-link>
						</li>
					</ul>
				</li>




				<li class="treeview"><a class="app-menu__item" href="" @click.prevent data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span class="app-menu__label">Owner Equity </span><i class="treeview-indicator fa fa-angle-right"></i></a>
					<ul class="treeview-menu">
						<li><router-link :to="{name:'ownerEquityCreate'}" class="treeview-item" ><i class="icon fa fa-dot-circle-o"></i>Add Equity </router-link></li>
						<li><router-link :to="{name:'ownerEquityList'}" class="treeview-item" ><i class="icon fa fa-dot-circle-o"></i> Manage Equity </router-link></li>
					</ul>
				</li>

				<li class="treeview">
					<a class="app-menu__item" href="" @click.prevent data-toggle="treeview">
						<i class="app-menu__icon fa fa-list-alt"></i>
						<span class="app-menu__label">Ledger</span><i class="treeview-indicator fa fa-angle-right"></i></a>
					<ul class="treeview-menu">
						<template v-for="account in $root.$data.accounts">
							<li>
								<router-link :to="{name:'ledgerShow',params:{id:account.id,type:account.account_type,name:account.name}}" class="treeview-item" >
									<i class="icon fa fa-dot-circle-o"></i>
									{{account.name}}
								</router-link>
							</li>
						</template>

					</ul>
				</li>
				<li class="treeview">
					<a class="app-menu__item" href="" @click.prevent data-toggle="treeview">
						<i class="app-menu__icon fa fa-clipboard"></i>
						<span class="app-menu__label">Vat Ledger</span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<template>
							<li><router-link :to="{name:'ledgerShow',params:{id:'vat',type:'income-vat',name:'received-vat'}}" class="treeview-item" href=" "><i class="icon fa fa-dot-circle-o"></i> Vat Receive </router-link></li>
							<li><router-link :to="{name:'ledgerShow',params:{id:'vat',type:'expense-vat',name:'paid-vat'}}" class="treeview-item" href=" "><i class="icon fa fa-dot-circle-o"></i> Vat Paid </router-link></li>
						</template>

					</ul>
				</li>
				<li class="treeview">
					<a class="app-menu__item" href="" @click.prevent data-toggle="treeview">
						<i class="app-menu__icon fa fa-book"></i>
						<span class="app-menu__label">Day Book</span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li>
							<router-link :to="{name:'dayBookShow',params:{type:'cash'}}" class="treeview-item" href=""><i class="icon fa fa-dot-circle-o"></i> Cash </router-link>
						</li>

						<li>
							<router-link :to="{name:'dayBookShow',params:{type:'bank'}}" class="treeview-item" href=""><i class="icon fa fa-dot-circle-o"></i> Bank </router-link>
						</li>

					</ul>
				</li>
	<template v-if="$root.$data.user.role =='admin'">
				<li class="treeview">
					<a class="app-menu__item" href="" @click.prevent data-toggle="treeview">
						<i class="app-menu__icon fa fa-book"></i>
						<span class="app-menu__label">Financial Statement</span>
						<i class="treeview-indicator fa fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li>
							<router-link class="treeview-item" :to="{name:'cashFlow'}">
								<i class="app-menu__icon fa fa-heart"></i>
								<span class="app-menu__label">Cash Flow</span>
							</router-link>
						</li>

						<li>
							<router-link class="treeview-item" :to="{name:'profitLoss'}">
								<i class="app-menu__icon fa fa-heart"></i>
								<span class="app-menu__label">Profit & Loss</span>
							</router-link>
						</li>
						<li>
							<router-link class="treeview-item" :to="{name:'financialStatementCreate'}">
								<i class="pp-menu__icon fa fa-newspaper-o"> </i>
								<span class="app-menu__label"> &nbsp;&nbsp;Balance Sheet</span>
							</router-link>
						</li>

					</ul>
				</li>
		</template>

</template>
				<!--<li class="foldSigleItem">-->
					<!--<router-link class="app-menu__item" :to="{name:'regularForm'}">-->
						<!--<i class="pp-menu__icon fa fa-newspaper-o"> </i>-->
						<!--<span class="app-menu__label"> &nbsp;  Regular Form</span>-->
					<!--</router-link>-->
				<!--</li>-->



			</ul>

		</aside>
	</div>

</template>
<script>
	export default {
	    data(){
	        return{

			}
		},
		computed:{
            is_loaded:function () {
				if(this.$root.$data.user){
                    $(document).ready(function(){
                        $(".foldSigleItem").click(function(){
                            //alert();
                            $(".app-menu li.treeview.is-expanded").removeClass("is-expanded") ;
                        });
                        $(".treeview").click(function(){
                            $(this).toggleClass("is-expanded");
                            $(this).siblings().removeClass("is-expanded") ;
                        });

                        $(".treeview-item").click(function(){
                            $(this).parents().eq(2).removeClass("is-expanded");
                        });

                        $(".app-sidebar__toggle").click(function(){
                            $('body').toggleClass("sidenav-toggled");
                        });


                    });
				    return true;

				}else{
				    return false;
				}

            }
		}
	}
</script>

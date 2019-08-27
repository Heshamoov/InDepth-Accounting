<template>
    <div>
        <div class="row">
            <div class="col-md-12 title">
                <div class="InputFormHeader"><i class="fas fa-dollar-sign"></i> Update Expense </div>
                <div class="tile" style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="updateExpense">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Date*</label>
                                    <date-picker
                                            v-model="expense.expense_date"
                                            :config="options"  v-validate="'required|min:3'"
                                            data-vv-name="expense_date"></date-picker>
                                    <div v-show="errors.has('expense_date')" class="help is-danger">
                                        {{ errors.first('expense_date') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Expense Type *</label>
                                    <v-select
                                            v-model="expense.account"
                                            :options="accounts"
                                            label="name"
                                            name="account"
                                            v-validate="'required|min:3'"
                                            data-vv-name="account"
                                            :class="{ 'is-danger': errors.has('account') }"
                                            @input="employeeReset"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('account')" class="help is-danger">
                                        {{ errors.first('account') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Ref *</label>
                                    <input
                                            class="form-control"
                                            v-model="expense.ref"
                                            type="text"
                                            name="ref"
                                            placeholder="Enter Ref"
                                            v-validate="'required|min:3'"
                                            data-vv-name="ref"
                                    >
                                    <div v-show="errors.has('ref')" class="help is-danger">
                                        {{ errors.first('ref') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 pt-2">
                                <div class="form-group d-flex">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Amount *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <input
                                                class="form-control"
                                                v-model="expense.amount"
                                                type="number"
                                                name="amount"
                                                placeholder="Enter Amount"
                                                v-validate="'required'"
                                                data-vv-name="amount"
                                                step="any"
                                        >
                                        <div v-show="errors.has('amount')" class="help is-danger">
                                            {{ errors.first('amount') }}
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group d-flex ">
                                    <div class="col-md-3 text-right">
                                        <label class="control-label">VAT(%) </label>
                                    </div>
                                    <div class="col-md-9">
                                        <input
                                                class="form-control"
                                                v-model="expense.tax_rate"
                                                type="number"
                                                name="tax_rate"
                                                step="any"
                                                placeholder="Enter Tax"
                                        >
                                    </div>
                                </div>
                                <div class="form-group d-flex">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">VAT Amount </label>
                                    </div>
                                    <div class="col-md-9">
                                        <input
                                                class="form-control"
                                                v-model="taxAmount"
                                                type="text"
                                                step="any"
                                                name="tax_amount"
                                                disabled
                                        >
                                    </div>
                                </div>
                                <div class="form-group d-flex">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Total Amount </label>
                                    </div>
                                    <div class="col-md-9">
                                        <input
                                                class="form-control"
                                                v-model="afterTaxAmount"
                                                type="text"
                                                step="any"
                                                name="after_tax_amount"
                                                disabled
                                        >
                                    </div>
                                </div>

                                <div class="form-group d-flex" v-if="expense.account?!expense.account.name.includes('Depreci'):false ||expense.account?!expense.account.name.includes('depreci'):false">
                                    <div class="col-md-3 text-right">
                                        <label class="control-label">Payment Type *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="expense.payment_type"
                                                :options="['Cash','Bank','Accounts Payable','Prepaid Expense']"
                                                label="name"
                                                name="payment_type"
                                                v-validate="'required'"
                                                data-vv-name="payment_type"
                                                :class="{ 'is-danger': errors.has('payment_type') }"
                                                @input="employeeReset()"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('payment_type')" class="help is-danger">
                                            {{ errors.first('payment_type') }}
                                        </div>
                                        <!--<a href="" @click.prevent="dueField=!dueField" v-if="expense.payment_type =='Cash' || expense.payment_type=='Bank'">+ Add Due</a>-->
                                    </div>

                                </div>
                                <div class="form-group d-flex"  v-if="expense.account?expense.account.name.includes('Depreci'):false || expense.account?expense.account.name.includes('depreci'):false">
                                    <div class="col-md-3 text-right">
                                        <label class="control-label">Payment Type *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="expense.payment_type"
                                                :options="['Cash','Bank','Accounts Payable','Depreciation Fund']"
                                                label="name"
                                                name="payment_type"
                                                v-validate="'required'"
                                                data-vv-name="payment_type"
                                                :class="{ 'is-danger': errors.has('payment_type') }"
                                                @input="employeeReset"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('payment_type')" class="help is-danger">
                                            {{ errors.first('payment_type') }}
                                        </div>
                                        <!--<a href="" @click.prevent="dueField=!dueField" v-if="expense.payment_type =='Cash' || expense.payment_type=='Bank'">+ Add Due</a>-->
                                    </div>

                                </div>


                                <div class="form-group d-flex"  v-if="dueField">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Due Amount *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <input
                                                class="form-control"
                                                v-model="expense.due_amount"
                                                type="number"
                                                name="due_amount"
                                                placeholder="Enter Due Amount"
                                                v-validate="'required'"
                                                data-vv-name="due_amount"
                                                step="any"
                                        >
                                        <div v-show="errors.has('due_amount')" class="help is-danger">
                                            {{ errors.first('due_amount') }}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group d-flex"  v-if="expense.payment_type=='Depreciation Fund'">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Asset *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="expense.asset"
                                                :options="assets"
                                                label="name"
                                                name="asset"
                                                v-validate="'required'"
                                                data-vv-name="asset"
                                                :class="{ 'is-danger': errors.has('asset') }"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('asset')" class="help is-danger">
                                            {{ errors.first('asset') }}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group d-flex"  v-if="expense.payment_type=='Prepaid Expense'">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Prepaid Asset *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="expense.asset"
                                                :options="prepaidAssets"
                                                label="name"
                                                name="asset"
                                                v-validate="'required'"
                                                data-vv-name="asset"
                                                :class="{ 'is-danger': errors.has('asset') }"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('asset')" class="help is-danger">
                                            {{ errors.first('asset') }}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group d-flex"  v-if="expense.payment_type=='Accounts Payable'">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Payable Holder *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="expense.payable_details"
                                                :options="payableHolders"
                                                label="name"
                                                name="payable_details"
                                                :v-validate="`${expense.payment_type =='Accounts Payable'? 'required' : ''}`"
                                                data-vv-name="payable_details"
                                                :class="{ 'is-danger': errors.has('payable_details') }"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('payable_details')" class="help is-danger">
                                            {{ errors.first('payable_details') }}
                                        </div>
                                    </div>
                                </div>
                                <template v-if="expense.account">
                                    <div class="form-group d-flex"  v-if="(expense.payment_type=='Cash'|| expense.payment_type=='Bank')&&(expense.account.name=='Wages'|| expense.account.name=='Wage'||expense.account.name=='wages'||expense.account.name=='wage')">
                                        <div class="col-md-3  text-right">
                                            <label class="control-label">Employee *</label>
                                        </div>
                                        <div class="col-md-9">
                                            <v-select
                                                    v-model="expense.employee"
                                                    :options="employees"
                                                    label="name"
                                                    name="employee"
                                                    v-validate="`${expense.payment_type !='Accounts Payable' || expense.payment_type!='Prepaid Expense'? 'required' : ''}`"
                                                    :class="{ 'is-danger': errors.has('employee') }"
                                            >
                                            </v-select>
                                            <div v-show="errors.has('employee')" class="help is-danger">
                                                {{ errors.first('employee') }}
                                            </div>
                                        </div>
                                    </div>
                                </template>

                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Description</label>
                                    <input
                                            class="form-control"
                                            v-model="expense.description"
                                            type="text"
                                            name="description"
                                            placeholder="Description">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button class="btn btn-primary" type="submit" :disabled="btnDisabled">
                                    <i class="fa fa-fw fa-lg fa-check-circle"></i>
                                    Update
                                </button>
                                <button class="btn btn-secondary" href="#" @click.prevent="cancel">
                                    <i class="fa fa-fw fa-lg fa-times-circle"></i>
                                    Cancel
                                </button>
                            </div>
                        </form>
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
                expense:{tax_rate:0},
                accounts:[],
                employees:[],
                payableHolders:[],
                assets:[],
                createdExpense:[],
                prepaidAssets:[],
                dueField:false,
                btnDisabled:false,
                options: {
                    format: 'DD/MM/YYYY',
                    useCurrent: true,
                },
                count:0,
            }
        },
        created(){
            axios.get('/expense/'+this.$route.params.id+'/edit').then(res=>{
                this.accounts=res.data.accounts
                this.payableHolders=res.data.payableHolders
                this.prepaidAssets=res.data.prepaidAssets
                this.assets=res.data.assets
                this.createdExpense=res.data.expense
                this.employees=res.data.employees
                this.expense=res.data.expense
                this.expense.expense_date=res.data.expense.expense_date?this.parseDate(res.data.expense.expense_date):null
                this.expense.payable_details=res.data.expense.modelable
                this.expense.asset=res.data.expense.asset

            })

        },
        computed:{
            taxAmount:function () {
                var taxAmount=this.expense.tax_rate && this.expense.amount?(this.expense.amount*this.expense.tax_rate)/100:0
                this.expense['tax_amount']=taxAmount
                return taxAmount
            },
            afterTaxAmount:function () {

                var taxAmount=(this.expense.amount*this.expense.tax_rate)/100
                var taxAfterAmount= this.expense.amount && taxAmount? this.expense.amount-taxAmount:this.expense.amount
                this.expense['after_tax_amount']=taxAfterAmount
                return  taxAfterAmount
            },
            employeeRequired:function () {
                if(this.expense.payment_type=='Cash' || this.expense.payment_type=='Bank'){
                    return 'required'
                }else {
                    return null
                }

            },
            payableRequired:function () {
                return this.expense.payment_type =='Accounts Payable'?'required':null
            }
        },
        methods: {
            updateExpense(){
                if(this.expense.pay!=null){
                    if(!this.expense.payable_details.hasOwnProperty('payable_type') && this.expense.payment_type=='Accounts Payable'){
                        if(this.expense.payable_details.account_type=='Liabilities-AP'){
                            this.expense.payable_details['payable_type']="App\\Account"
                        }else{
                            this.expense.payable_details['payable_type']="App\\Employee"
                        }
                    }
                }


                this.$validator.validateAll().then((result) => {
                    if (result) {
                        this.btnDisabled=true
                        this.expense['asset_id']=this.expense.asset?this.expense.asset.id:null
                        this.expense['employee_id']=this.expense.employee?this.expense.employee.id:null
                        axios.patch('/expense/'+this.$route.params.id,this.expense).then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.btnDisabled=false
                        }).catch(error => {
                            let err
                            let errs = error.response.data.errors
                            for (err in errs) {
                                this.errors.add({
                                    'field': err,
                                    'msg': errs[err][0]
                                })
                            }
                        })
                    }
                })
            },
            employeeReset(){
                this.count++
              if(this.count>2){
                  this.expense.employee = null
                  this.expense.payable_details= null
                  this.expense.asset= null
              }

            },
            parseDate(val){
                var spliceDate = val.slice(0,10)
                const [year, month, day] =spliceDate.split('-')
                return day+'/'+month+'/'+year
            },
            cancel(){
                this.$router.push({path:'/expense'})
            }

        }
    }
</script>
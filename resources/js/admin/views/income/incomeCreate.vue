<template>
    <div>
        <div class="row">
            <div class="col-md-12 title">
                <div class="InputFormHeader"><i class="far fa-money-bill-alt"></i> Add Income / Sales</div>
                <div class="tile" style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="postIncome">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Date*</label>
                                    <date-picker
                                            v-model="income.income_date"
                                            :config="options"  v-validate="'required|min:3'"
                                            data-vv-name="income_date"></date-picker>
                                    <div v-show="errors.has('income_date')" class="help is-danger">
                                        {{ errors.first('income_date') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Inocme  Type *</label>
                                    <v-select
                                            v-model="income.account"
                                            :options="accounts"
                                            label="name"
                                            name="account"
                                            v-validate="'required|min:3'"
                                            data-vv-name="account"
                                            :class="{ 'is-danger': errors.has('account') }"
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
                                            v-model="income.ref"
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
                                                v-model="income.amount"
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
                                                v-model="income.tax_rate"
                                                type="number"
                                                step="any"
                                                name="tax_rate"
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
                                                name="after_tax_amount"
                                                disabled
                                        >

                                    </div>
                                </div>

                                <div class="form-group d-flex">
                                    <div class="col-md-3 text-right">
                                        <label class="control-label">Payment Type *</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="income.payment_type"
                                                :options="['Cash','Bank','Accounts Receivable']"
                                                label="name"
                                                name="payment_type"
                                                v-validate="'required'"
                                                data-vv-name="payment_type"
                                                :class="{ 'is-danger': errors.has('payment_type') }"
                                                @input="receivableReset"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('payment_type')" class="help is-danger">
                                            {{ errors.first('payment_type') }}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group d-flex"  v-if="income.payment_type=='Accounts Receivable'">
                                    <div class="col-md-3  text-right">
                                        <label class="control-label">Receivable Holder*</label>
                                    </div>
                                    <div class="col-md-9">
                                        <v-select
                                                v-model="income.payable_details"
                                                :options="receivableHolders"
                                                label="name"
                                                name="payable_details"
                                                v-validate="'required'"
                                                data-vv-name="payable_details"
                                                :class="{ 'is-danger': errors.has('payable_details') }"
                                        >
                                        </v-select>
                                        <div v-show="errors.has('payable_details')" class="help is-danger">
                                            {{ errors.first('payable_details') }}
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Description</label>
                                    <input
                                            class="form-control"
                                            v-model="income.description"
                                            type="text"
                                            name="description"
                                            placeholder="Description">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button class="btn btn-primary" type="submit" :disabled="btnDisabled">
                                    <i class="fa fa-fw fa-lg fa-check-circle"></i>
                                    Add
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
                income:{tax_rate:0,income_date:new Date()},
                accounts:[],
                receivableHolders:[],
                btnDisabled:false,
                options: {
                    format: 'DD/MM/YYYY',
                    useCurrent: true,
                },
            }
        },
        created(){
            axios.get('/income/create').then(res=>{
                this.accounts=res.data.accounts
                this.receivableHolders=res.data.receivableHolders
            })
        },
        computed:{
            taxAmount:function () {
                var taxAmount=this.income.tax_rate && this.income.amount?(this.income.amount*this.income.tax_rate)/100:0
                this.income['tax_amount']=taxAmount
                return taxAmount
            },
            afterTaxAmount:function () {

                var taxAmount=(this.income.amount*this.income.tax_rate)/100
                var taxAfterAmount= this.income.amount && taxAmount? this.income.amount-taxAmount:this.income.amount
                this.income['after_tax_amount']=taxAfterAmount
                return  taxAfterAmount
            }
        },
        methods: {
            postIncome(){
                this.$validator.validateAll().then((result) => {
                    if (result) {
                        this.btnDisabled=true
                        this.income['asset_id']=this.income.payable_details?this.income.payable_details.id:null
                        axios.post('/income',this.income).then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.$validator.reset()
                            this.income={tax_rate:0,income_date:new Date()}
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
            receivableReset(){
                this.income.payable_details=null
            },
            cancel(){
                this.$router.push({path:'/income'})
            }

        }
    }
</script>

<style scoped>

</style>

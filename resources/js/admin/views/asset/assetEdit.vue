<template>
    <div>
        <div class="row">
            <div class="col-md-12 title">
                <div class="InputFormHeader"><i class="fa fa-th-list"></i> - Update Asset Transaction</div>
                <div class="tile" style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="postAsset">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Date*</label>
                                    <date-picker
                                            v-model="asset.asset_date"
                                            :config="options" v-validate="'required|min:3'"
                                            data-vv-name="asset_date"></date-picker>
                                    <div v-show="errors.has('asset_date')" class="help is-danger">
                                        {{ errors.first('asset_date') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Ref *</label>
                                    <input
                                            class="form-control"
                                            v-model="asset.ref"
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
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Asset Type *</label>
                                    <v-select
                                            v-model="asset.account"
                                            :options="accounts"
                                            label="name"
                                            name="account"
                                            v-validate="'required|min:3'"
                                            data-vv-name="account"
                                            :class="{ 'is-danger': errors.has('account') }"
                                            @input="changePaymentType(),changeTransactionType()"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('account')" class="help is-danger">
                                        {{ errors.first('account') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 pt-2">
                                <div class="form-group">
                                    <label class="control-label">Transaction Type *</label>
                                    <v-select
                                            v-model="asset.transaction_type"
                                            :options="transactionOptions"
                                            label="name"
                                            name="transaction_type"
                                            v-validate="'required|min:3'"
                                            data-vv-name="transaction_type"
                                            :class="{ 'is-danger': errors.has('transaction_type') }"
                                            @input="changePaymentType()"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('transaction_type')" class="help is-danger">
                                        {{ errors.first('transaction_type') }}
                                    </div>
                                </div>
                                <div class="form-group" v-if="asset.transaction_type=='Adjust'">
                                    <label class="control-label">Adjust For*</label>
                                    <v-select
                                            v-model="asset.expense"
                                            :options="expenses"
                                            label="name"
                                            name="expense"
                                            v-validate="'required|min:3'"
                                            data-vv-name="expense"
                                            :class="{ 'is-danger': errors.has('expense') }"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('expense')" class="help is-danger">
                                        {{ errors.first('expense') }}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Amount *</label>
                                    <input
                                            class="form-control"
                                            v-model="asset.amount"
                                            type="number"
                                            step="any"
                                            name="amount"
                                            placeholder="Enter Amount"
                                            v-validate="'required'"
                                            data-vv-name="amount"
                                    >
                                    <div v-show="errors.has('amount')" class="help is-danger">
                                        {{ errors.first('amount') }}
                                    </div>
                                </div>
                                <div class="form-group" v-if="asset.transaction_type!='Adjust'">
                                    <label class="control-label">Payment Type *</label>
                                    <v-select
                                            v-model="asset.payment_type"
                                            :options="paymentOptions"
                                            label="name"
                                            name="payment_type"
                                            v-validate="'required|min:3'"
                                            data-vv-name="payment_type"
                                            :class="{ 'is-danger': errors.has('payment_type') }"
                                            @input="resetLiability"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('payment_type')" class="help is-danger">
                                        {{ errors.first('payment_type') }}
                                    </div>
                                </div>

                                <div class="form-group" v-if="asset.payment_type=='Accounts Payable'">
                                    <label class="control-label">Payable Holder *</label>
                                    <v-select
                                            v-model="asset.liability"
                                            :options="payableHolders"
                                            label="name"
                                            name="liability"
                                            v-validate="'required|min:3'"
                                            data-vv-name="liability"
                                            :class="{ 'is-danger': errors.has('liability') }"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('liability')" class="help is-danger">
                                        {{ errors.first('liability') }}
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Description</label>
                                    <input
                                            class="form-control"
                                            v-model="asset.description"
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
                asset:{},
                accounts:[],
                payableHolders:[],
                paymentOptions: [],
                transactionOptions: [],
                btnDisabled:false,options: {
                    format: 'DD/MM/YYYY',
                    useCurrent: true,
                },
                count:0,
                anotherCount:0,
            }
        },
        created(){
            axios.get('/asset/'+this.$route.params.id+'/edit').then(res=>{
                this.accounts=res.data.accounts
                this.payableHolders=res.data.payableHolders
                this.asset=res.data.asset
                this.asset.liability=res.data.asset.account_payable
                this.asset.asset_date=this.parseDate(res.data.asset.asset_date)
            })
        },
        methods: {
            postAsset(){

                this.$validator.validateAll().then((result) => {
                    if (result) {
                        this.btnDisabled=true
                        this.asset['liability_id']=this.asset.liability?this.asset.liability.id:null
                        axios.patch('/asset/'+this.$route.params.id,this.asset).then(response => {
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
            resetLiability(){
                this.count++
                if(this.count>1){
                    this.asset.liability=null
                }
            },
            resetTransactionType(){
                this.anotherCount++
                if(this.anotherCount>1){
                    this.asset.transaction_type=null
                }

            },
            parseDate(val){
                var spliceDate = val.slice(0,10)
                const [year, month, day] =spliceDate.split('-')
                return day+'/'+month+'/'+year
            },
            cancel(){
                this.$router.push({path:'/asset'})
            },
            changePaymentType() {
                var accountType = this.asset.account.account_type
                var tranType = this.asset.transaction_type
                if (accountType == 'Fixed Asset' && (tranType != 'Sold' && tranType!='Initial')) {

                    this.paymentOptions = ['Cash', 'Bank', 'Accounts Payable', 'Owner Equity']
                } else if ((accountType == 'Current Asset' || tranType == 'Sold')&& tranType!='Initial') {
                    this.paymentOptions = ['Cash', 'Bank', 'Owner Equity']
                } else if(tranType == 'Initial'){
                    this.paymentOptions = ['Owner Equity']
                }
                else {
                    this.paymentOptions = ['Cash', 'Bank']
                }
            },
            changeTransactionType() {
                this.resetTransactionType();
                var accountType = this.asset.account.account_type
                if (accountType == 'Fixed Asset') {
                    this.transactionOptions = ['Purchase', 'Sold', 'Initial']
                } else if (accountType == 'Current Asset') {
                    this.transactionOptions = ['Initial', 'Adjust']
                } else {
                    this.transactionOptions = ['Receive', 'Payment']
                }


            }

        }
    }
</script>
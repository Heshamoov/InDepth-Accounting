<template>
    <div>
        <div class="row">
            <div class="col-md-12 title">
                <div class="InputFormHeader"><i class="fa fa-th-list"></i> Add Liability Transaction</div>
                <div class="tile"  style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="postAsset">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Date*</label>
                                    <date-picker
                                            v-model="liability.liability_date"
                                            :config="options"  v-validate="'required|min:3'"
                                            data-vv-name="liability_date"></date-picker>
                                    <div v-show="errors.has('liability_date')" class="help is-danger">
                                        {{ errors.first('liability_date') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Ref *</label>
                                    <input
                                            class="form-control"
                                            v-model="liability.ref"
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
                                    <label class="control-label">Liability Type *</label>
                                    <v-select
                                            v-model="liability.account"
                                            :options="accounts"
                                            label="name"
                                            name="account"
                                            v-validate="'required|min:3'"
                                            data-vv-name="account"
                                            :class="{ 'is-danger': errors.has('account') }"
                                            @input="setTansactionType()"
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
                                            v-model="liability.transaction_type"
                                            :options="transactionOptions"
                                            label="name"
                                            name="transaction_type"
                                            v-validate="'required|min:3'"
                                            data-vv-name="transaction_type"
                                            :class="{ 'is-danger': errors.has('transaction_type') }"
                                            @input="setPaymentType()"
        
                                    >
                                    </v-select>
                                    <div v-show="errors.has('transaction_type')" class="help is-danger">
                                        {{ errors.first('transaction_type') }}
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="control-label">Amount *</label>
                                    <input
                                            class="form-control"
                                            v-model="liability.amount"
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
                                <div class="form-group">
                                    <label class="control-label">Payment Type *</label>
                                    <v-select
                                            v-model="liability.payment_type"
                                            :options="paymentOptions"
                                            label="name"
                                            name="payment_type"
                                            v-validate="'required|min:3'"
                                            data-vv-name="payment_type"
                                            :class="{ 'is-danger': errors.has('payment_type') }"
                                            @input="liability.asset=null"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('payment_type')" class="help is-danger">
                                        {{ errors.first('payment_type') }}
                                    </div>
                                </div>

                                <div class="form-group" v-if="liability.payment_type=='Accounts Receivable'">
                                    <label class="control-label">Receivable Holder *</label>
                                    <v-select
                                            v-model="liability.asset"
                                            :options="receivableHolders"
                                            label="name"
                                            name="asset"
                                            v-validate="'required|min:3'"
                                            data-vv-name="asset"
                                            :class="{ 'is-danger': errors.has('asset') }"
                                    >
                                    </v-select>
                                    <div v-show="errors.has('asset')" class="help is-danger">
                                        {{ errors.first('asset') }}
                                    </div>
                                </div>
                            </div>
 
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Description</label>
                                    <input
                                            class="form-control"
                                            v-model="liability.description"
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
                liability:{liability_date:new Date()},
                accounts:[],
                receivableHolders:[],
                btnDisabled:false,options: {
                    format: 'DD/MM/YYYY',
                    useCurrent: true,
                },
                paymentOptions:[],
                transactionOptions:[],
            }
        },
        created(){
            axios.get('/liability/create').then(res=>{
                this.accounts=res.data.accounts
                this.receivableHolders=res.data.receivableHolders
            })
        },
        methods: {
            postAsset(){

                this.$validator.validateAll().then((result) => {
                    if (result) {
                        this.btnDisabled=true
                        this.liability['asset_id']=this.liability.asset?this.liability.asset.id:null
                        axios.post('/liability',this.liability).then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.$validator.reset()
                            this.liability={liability_date:new Date()}
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
            cancel(){
                this.$router.push({path:'/liability'})
            },
            setTansactionType(){
                this.liability.transaction_type=null
                var accountType = this.liability.account.account_type
                if (accountType == 'Liabilities-AP') {
                    this.transactionOptions = ['Payment', 'Receive']
                } else if (accountType == 'Employee') {
                    this.transactionOptions = ['Payment']
                } else {
                    this.transactionOptions = ['Receive', 'Payment','Initial']
                }
            },
            setPaymentType(){

                var accountType = this.liability.account.account_type
                var tranType = this.liability.transaction_type
                if (tranType!='Initial' && (tranType=='Payment' || tranType=='Receive')) {
                    this.paymentOptions = ['Cash', 'Bank']
                }else if(tranType=='Initial'){
                    this.paymentOptions = ['Owner Equity']
                }
                else {
                    this.paymentOptions = ['Cash', 'Bank']
                }
            }

        }
    }
</script>

<style scoped>

</style>

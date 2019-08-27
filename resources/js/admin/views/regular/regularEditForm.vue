<template>
    <div>
        <form action="" @submit.prevent="updateRegular" class="pb-4">
            <div class="row mx-auto">
                <div class="col-md-3">
                    <div class="form-group" >
                        <label class="control-label">Date*</label>
                        <date-picker
                                v-model="regular.date"
                                :config="options" v-validate="'required'"
                                data-vv-name="date">
                        
                        </date-picker>
                        <div v-show="errors.has('date')" class="help is-danger">
                            {{ errors.first('date') }}
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label class="control-label">Name</label>
                        <input
                                class="form-control"
                                v-model="regular.name"
                                type="text"
                                v-validate="'required|min:3'"
                                data-vv-name="name"
                                name="name"
                                placeholder="Name">
                        <div v-show="errors.has('name')" class="help is-danger">
                            {{ errors.first('name') }}
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <label class="control-label">AGT</label>
                        <input
                                class="form-control"
                                v-model="regular.agt"
                                type="text"
                                name="agt"
                                placeholder="Agt">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <label class="control-label">Ref</label>
                        <input
                                class="form-control"
                                v-model="regular.ref"
                                type="text"
                                name="ref"
                                placeholder="ref">
                    </div>
                </div>
                <!--<div class="col-md-2">-->
                    <!--<div class="form-group">-->
                        <!--<label class="control-label">M.R</label>-->
                        <!--<input-->
                                <!--class="form-control"-->
                                <!--v-model="regular.mr"-->
                                <!--type="text"-->
                                <!--name="mr"-->
                                <!--placeholder="MR">-->
                    <!--</div>-->
                <!--</div>-->
            </div>
            <hr>
            <div class="col-md-12 row ">
                <div class="col-md-6 row  mx-auto  border-right">
                    <div class="row pt-4">
                        <div class="col-md-4 ">
                            <div class="form-group">
                                <label class="control-label">Cash</label>
                                <input
                                        class="form-control"
                                        v-model="regular.cash"
                                        type="number"
                                        step="any"
                                        name="cash"
                                        placeholder="cash">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group ">
                                <label class="control-label">Bank</label>
                                <input
                                        class="form-control"
                                        v-model="regular.bank"
                                        type="number"
                                        step="any"
                                        name="bank"
                                        placeholder="Bank">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group ">
                                <label class="control-label">Eviivo</label>
                                <input
                                        class="form-control"
                                        v-model="regular.eviivo"
                                        type="number"
                                        step="any"
                                        name="eviivo"
                                        placeholder="Eviivo">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group ">
                                <label class="control-label">Return</label>
                                <input
                                        class="form-control"
                                        v-model="regular.return"
                                        type="number"
                                        step="any"
                                        name="return"
                                        placeholder="Return">
                            </div>
                        </div>
                    
                    </div>
                
                </div>
                <div class="col-md-6">
                    <div class="row"><br>
                        <div class="col-md-12"><br>
                            <h3 class="pl-2">Parking</h3>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group own-form-size">
                                <label class="control-label">Cash</label>
                                <input
                                        class="form-control"
                                        v-model="regular.parking_cash"
                                        type="number"
                                        step="any"
                                        name="parking_cash"
                                        placeholder="Cash">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group own-form-size">
                                <label class="control-label">Card</label>
                                <input
                                        class="form-control"
                                        v-model="regular.parking_card"
                                        type="number"
                                        step="any"
                                        name="parking_card"
                                        placeholder="Card">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group own-form-size">
                                <label class="control-label">Other Sales</label>
                                <input
                                        class="form-control"
                                        v-model="regular.other_sales"
                                        type="number"
                                        step="any"
                                        name="other_sale"
                                        placeholder="Other Sale">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group own-form-size">
                                <label class="control-label">Advance Sales</label>
                                <input
                                        class="form-control"
                                        v-model="regular.advance_sales"
                                        type="number"
                                        step="any"
                                        name="other_sale"
                                        placeholder="Advance Sale">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group own-form-size">
                                <label class="control-label">Remark</label>
                                <input
                                        class="form-control"
                                        v-model="regular.remark"
                                        type="text"
                                        name="remark"
                                        placeholder="Remark">
                            </div>
                        </div>
                    </div>
                
                </div>
            </div>
            <div class="col-md-12 row "><br>
                <button class="btn btn-primary mr-2" type="submit" :disabled="btnDisabled">
                    <i class="fa fa-fw fa-lg fa-check-circle"></i>
                    Update
                </button>
                <button class="btn btn-secondary"  @click.prevent="cancel">
                    <i class="fa fa-fw fa-lg fa-times-circle"></i>
                    Cancel
                </button>
            </div>
        </form>
    </div>
</template>

<script>
    export default {
        props:{
            id:{
               type:Number,
               default:()=>null
            }
        },
        data(){
            return{
                regular:{},
                options: {
                    format: 'DD/MM/YYYY HH:mm:ss',
                    useCurrent: true,
                },
                btnDisabled:false
            }
        },
        created(){
          this.getData()
        },
        methods:{
            getData(){
                axios.get('/regular-form/'+this.id+'/edit').then(res=>{
                        this.regular=res.data
                    this.regular.date=this.parseDateTime(res.data.date)
                })
            },
            updateRegular(){
                this.$validator.validateAll().then((result) => {
                    if (result) {
                        this.btnDisabled = true
                        axios.patch('/regular-form/'+this.id, this.regular).then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.$validator.reset()
                            this.regular = {}
                            this.$parent.callEditModal(false)
                            this.$router.push({path:'/regular'})
                            this.btnDisabled = false
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
                this.$parent.callEditModal(false)
                this.$router.push({path:'/regular'})

            },
            parseDateTime(value){

                    var date=value.slice(0,10)
                    var time=value.slice(11,19)
                    const [year,month,day]=date.split('-')
                    const [hour,minute,sec]=time.split(':')
                    return day+'-'+month+'-'+year+' '+hour+':'+minute+':'+sec

            }
        }
    }
</script>
<style scoped>
    .own-form-size{
        padding-left: 5px!important;
        padding-right: 5px!important;
    }
</style>

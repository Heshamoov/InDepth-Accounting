<template>
    <div>
        <div class="row">
            <div class="col-md-12 title">
                <div class="InputFormHeader"><i class="fa fa-user-plus"></i> Add Employee</div>
                <div class="tile" style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="postEmployee">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Name *</label>
                                    <input
                                            :class="{'form-control': true, 'is-danger': errors.has('name') }"
                                            v-model="employee.name"
                                            type="text"
                                            name="name"
                                            v-validate="'required|min:3'"
                                            data-vv-name="name"
                                            placeholder="Enter full name">
                                    <div v-show="errors.has('name')" class="help is-danger">
                                        {{ errors.first('name') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> Employee ID *</label>
                                    <input
                                            v-model="employee.id_card"
                                            type="text"
                                            name="id_card"
                                            placeholder="ID No"
                                            :class="{'form-control': true, 'is-danger': errors.has('id_card') }"
                                            data-vv-name="id_card"
                                            v-validate="'required'"
                                    >
                                    <div v-show="errors.has('id_card')" class="help is-danger">
                                        {{ errors.first('id_card') }}
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Email</label>
                                    <input
                                            class="form-control"
                                            v-model="employee.email"
                                            type="email"
                                            name="email"
                                           placeholder="Enter email address">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Phone</label>
                                    <input class="form-control" v-model="employee.phone" type="number"
                                           placeholder="Enter Phone">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="control-label">Address</label>
                                    <input
                                            class="form-control"
                                            v-model="employee.address"
                                            type="text"
                                            name="address"
                                           placeholder="Address">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button class="btn btn-primary" type="submit">
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
                sError:{},
                employee:{}
            }
        },
        methods: {
            postEmployee(){
                this.$validator.validateAll().then((result) => {
                    if (result) {
                        axios.post('/employee',this.employee).then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.$validator.reset()
                            this.employee={}
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
                this.$router.push({path:'/employee'})
            }

        }
    }
</script>

<style scoped>

</style>

<template>
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="InputFormHeader">Company Account Details</div>
                <div class="tile" style="box-shadow: none">
                    <div class="tile-body">
                        <form class="row" @submit.prevent="postCompany">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Company Name *</label>
                                    <input
                                            :class="{'form-control': true, 'is-danger': errors.has('name') }"
                                            v-model="company.name"
                                            type="text"
                                            name="name"
                                            v-validate="'required|min:3'"
                                            data-vv-name="name"
                                            placeholder="Enter Company name">
                                    <div v-show="errors.has('name')" class="help is-danger">
                                        {{ errors.first('name') }}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Mobile</label>
                                    <input
                                            :class="{'form-control': true, 'is-danger': errors.has('mobile') }"
                                            v-model="company.mobile"
                                            type="text"
                                            name="mobile"
                                            v-validate="'required|min:3'"
                                            data-vv-name="mobile"
                                            placeholder="Enter mobile">
                                    <div v-show="errors.has('mobile')" class="help is-danger">
                                        {{ errors.first('mobile') }}
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Address</label>
                                    <input
                                            class="form-control"
                                            v-model="company.address"
                                            type="text"
                                            name="address"
                                            placeholder="Address">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">
                                        Logo
                                        <small class="text-danger">
                                            (Show your logo better way please put this size)
                                        <span class="badge badge-danger p-1">175px X 50px</span>
                                        </small>
                                    </label>
                                    <input type="file"
                                           class="upload-logo text-white bg-dark form-control"
                                           id="logo"
                                           name="image_path"
                                    >
                                </div>
                                <template v-if="company.image_path">
                                    <div style="padding: 20px">
                                        <img :src="'/storage/'+company.image_path" height="100px" width="100px"/>

                                    </div>
                                </template>

                            </div>

                            <div class="col-md-12">
                                <button class="btn btn-primary" type="submit" id="pressButton">
                                    <i class="fa fa-fw fa-lg fa-check-circle"></i>
                                    Submit
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
                company:{},
            }
        },
        created(){
            axios.get('/company/1/edit').then(res=>{
                this.company=res.data
            })
        },
        methods: {
            postCompany(){
                this.$validator.validateAll().then((result) => {
                    if (result) {
                        var data = new FormData()
                        var imagefile = document.querySelector('#logo')
                        data.append("file", imagefile.files[0])
                        data.append('company',JSON.stringify(this.company))

                        axios.post('/company',data,{
                            headers: {
                                'Content-Type': 'multipart/form-data'
                            }
                        })
                            .then(response => {
                            this.$swal({
                                type: response.data.type,
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500
                            })
                            this.$validator.reset()
                            this.$router.push({path:'/dashboard'})
                            window.location.reload();
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
                this.$router.push({path:'/dashboard'})
            }

        }
    }
</script>

<style scoped>

</style>

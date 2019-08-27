<template>
    <header class="app-header">
	    <router-link :to="{name:'dashboard'}" class="app-header__logo">
		    <img :src="'/storage/'+$root.$data.company.image_path" alt="AMSL" class="brand" v-if="checkCompany">
        </router-link>
			<!-- Sidebar toggle button-->
	    <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar">
		    <i class="fas fa-bars"></i>
	    </a>
			<!-- Navbar Right Menu-->
			<ul class="app-nav">
				<!-- User Menu-->
				<template v-if="$root.$data.user">
					<li class="pt-3 text-white" style="text-transform: capitalize">{{$root.$data.user.name}}<span style="text-transform: capitalize">{{' ('+$root.$data.user.role+') '}}</span></li>
				</template>

				<li class="dropdown">
					<a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu">
						<i class="fa fa-cog"></i>
					</a>
					<ul class="dropdown-menu settings-menu dropdown-menu-right">
						<template v-if="$root.$data.user?$root.$data.user.role=='admin':false">
                            <li>
                                <router-link :to="{name:'companyDetails'}" class="dropdown-item" href=""><i class="text-primary fa fa-building"></i>
                                    Company Settings
                                </router-link>
                            </li>

						<li>
                            <router-link :to="{name:'userDetails'}" class="dropdown-item" href="">
	                            <i class="fa fa-users text-secondary"></i>
	                            User Settings
                            </router-link>
                        </li>


						</template>
						<!--<li><a class="dropdown-item" href="page-user.html"><i class="fa fa-user fa-lg"></i> Profile</a></li>-->
						<li>
							<a class="dropdown-item" href="#" @click.prevent="logout">
								<i class="fa fa-sign-out text-danger"></i>
								Logout
							</a>
							
						</li>
					</ul>
				</li>
			</ul>
		</header>
</template>
<script>
	export default {
	    data(){
	      return{

		  }
		},
        computed:{
            checkCompany(){
                if(this.$root.$data.company){
                    return true
                }else{
                    return false
                }

            }
        },
	    methods:{
	        logout(){
	            axios.post('/logout').then(res=>{
                    this.$router.push({path:'/login'})
                    window.location.reload(true)
				})


			}
		}
	}
</script>

<template>
     <div>        
        <transition name="fade">
            <div class="alert mt-4" v-bind:class="alertType" v-if="showAlert" role="alert">
                {{alertMessage}}          
            </div>
        </transition>
        <ul class="nav nav-tabs nav-vue">
            <li class="nav-item">
                <router-link to="/" class="nav-link">Hauptseite</router-link>                
            </li>  
            <li class="nav-item">                
                <router-link to="/store" class="nav-link">VUEX-Beispiel</router-link>
            </li>           
            <li class="nav-item">                
                <router-link to="/unknown" class="nav-link">Unbekannte Seite</router-link>
            </li>    
        </ul>
        <div class="tab-content main-vue">
            <div class="mx-3 mt-4 mb-3">  
                <router-view />
            </div>
        </div>        
    </div>
</template>
<script>
    export default {
        data: function(){
            return {

            }
        },
        computed: {
            alertType: function(){
                return this.$store.getters.getAlertType;
            },
            showAlert: function(){
                return this.$store.getters.getAlertState;
            },
            alertMessage: function(){
                return this.$store.getters.getAlertMessage;
            }
        }
    }
</script>
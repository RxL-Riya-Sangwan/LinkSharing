package link_sharing


import grails.transaction.Transactional

class HomeController {

    static allowedMethods = ['index': 'GET', 'login': ['GET', 'POST'], 'register': ['GET','POST'], forgotPassword: ['GET', 'POST']]
    
//    def sessionFactory -- Use it to create a new Session

    def homeService

//    def beforeInterceptor = [action: this.&auth, except: ['login', 'register']]

//    private auth(){
//        if(!session['username']){
////            println 'In Auth'
//            redirect(action: 'login')
//            return false
//        }
//    }

    def index(){

         if(!session['username']){
             redirect(action: 'login')
         }
        else{
             UserData usr = UserData.findByUsername(session['username'])
             List <Topic> topicList = Topic.findAllByCreatedBy(usr)
             if (!topicList){
                 topicList = []
             }
             render(view: 'dashboard', model: [newUser: usr, topicList: topicList])
         }
    }

    @Transactional
    def register() {
        if (request.method == 'GET') {
            render(view: 'register')
        }
        else {

            Result res = homeService.getRegisterData(params, session)

            if(res.code == 1){
                flash.message = res.value
                redirect(action: 'login')
            }
            else if(res.code == 2){
                render(view: 'register')
            }
            else{
                flash.message = res.value
                redirect(action: 'index')
            }
        }

    }
    @Transactional
    def login(){
        if (request.method == 'GET'){
            render(view: 'home')
        }
        else{
            Result result  = homeService.getLoginData(params, session)

                if(result.code == 404){
                    flash.message = result.value
                    redirect(action: 'register')

                }
                else if(result.code == 401){
                    flash.message = result.value
                    redirect(action: 'forgotPassword')
                }
                else{
                    flash.message = result.value
                    redirect(controller: 'home', action:'index')
                }
        }
    }

    @Transactional
    def forgotPassword(){
        if (request.method == 'GET'){
            render(view: 'forgotPassword')
        }
        else{
            if (!UserData.findByEmail(params.email)){
                flash.message = "Account with '${params.email}' is not registered"
                render(view: 'home')
            }
            else{
                println 'Sending Mail'
                // Do the functionality for email reset
                render(view: 'home')
            }
        }
    }

    @Transactional
    def logout(){
//        println 'logout'
        session.invalidate();
//        Session session = sessionFactory.currectsession
//        session.flush()
//        session.clear()
        flash.message = "You're logged out!"
        redirect(controller: 'home', action: 'login')
    }
}
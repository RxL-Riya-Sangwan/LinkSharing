package link_sharing

import grails.converters.JSON
import grails.transaction.Transactional
import org.hibernate.Session
import org.springframework.web.multipart.MultipartFile

class HomeController {

    static allowedMethods = ['index': 'GET', 'login': ['GET', 'POST'], 'register': ['GET','POST'], forgotPassword: ['GET', 'POST']]
    
//    def sessionFactory -- Use it to create a new Session
    def homeService

    def index(){
        println "${session['username']}"

        if (session['username']){
            render(view: 'home')
        }
        else{
            render(view: 'login')
        }
    }
    

    def register(){
        if (request.method == 'GET'){
            render(view: 'home')
        }
        else{

            UserData user1 = UserData.findByEmail(params.email)

            if (user1){
                println 'Email taken'
                flash.message = 'Email already taken'
                render(view: 'login')
            }

            user1 = UserData.findByUsername(params.username)

            if(user1) {
                println 'Username taken'
                flash.message = 'Username taken'
                render(view: 'login')
            }
            else if(params.password != params.confirmPassword){
                println 'Not same password'
                render(view: 'home')
            }
            else{

                if (params.photo){
                    MultipartFile file = params.photo as MultipartFile
                    byte [] picture = file.getBytes();
                    params.photo = picture
                }

                println 'creating new object'
//                bindData(user1, params, [exclude: 'confirmPassword'])
                UserData newUser = new UserData(params)
                newUser.isActive = true
                newUser.isAdmin = false

                if(!newUser.validate()){
                    println 'validating'
                    response.status = 404
                    flash.message = 'Issues with Validation!'
                    render(view: 'home')
                }
                else if (newUser == null){
                    println 'Null Object'
                    render(view: 'home')
                }
                else if (newUser.hasErrors()){
                    println newUser.errors
                    render(view: 'home')
                }
                else{
                    newUser.save(failOnError: true, flush: true)
//                    id is readOnly -- cannot be used
//                    session['id'] = newUser.getId()
                    session['username'] = newUser.getUsername()
                    if (newUser.isAdmin){
                        session['role'] = 'admin'
                    }
                    else{
                        session['role'] = 'notAdmin'
                    }

                    response.status = 200

                    List <Subscription> li1 = Subscription.findAllByUserdata('riya')
                    Integer subCount = li1.size()


                    List <Topic> li2 = Topic.findAllByUserdata('riya')
                    Integer topicCount = li2.size()

                    render(view: 'dashboard', model: [newUser: newUser, subCount: subCount, topicCount: topicCount])
                }

            }
        }

    }


    @Transactional
    def login(){
        if (request.method == 'GET'){
            render(view: 'login')
        }
        else{

            Result result  = homeService.getloginData(params, session)

            if (result.user){
                render(view: 'dashboard', model: [newUser: result.user])

            }else{
                if(result.code == 402){
                    flash.message = result.value
                    render(view: 'login')
                }
                else if(result.code == 401){
                    flash.message = result.value
                    render(view: 'forgotPassword')
                }
                else{
                    flash.message = result.value
                    render(view: 'home')
                }
            }


//            UserData user1 = UserData.findByUsername(params.username);
//
//            if (!user1){
//                user1 = UserData.findByEmail(params.username)
//            }
//            if (user1){
//                if  (params.password == user1.password){
////                    session['id'] = user1.getId()
//                    session['username'] = user1.getUsername()
//                    if (user1.isAdmin){
//                        session['role'] = 'admin'
//                    }
//                    else{
//                        session['role'] = 'notAdmin'
//                    }
//                    println "${session['username']}"
//                    render(view: 'dashboard', model: [newUser: user1])
//                }
//                else{
//                    flash.message = 'Incorrect credentials'
//                    render(view: 'forgotPassword')
//                }
//            }
//            else{
//                flash.message = "You're not registered yet!"
//                render(view: 'home')
//            }



        }
    }

    def forgotPassword(){
        if (request.method == 'GET'){
            render(view: 'forgotPassword')
        }
        else{
            if (!UserData.findByEmail(params.email)){
                flash.message = 'Account with this email is not registered'
                render(view: 'home')
            }
            else{
                println 'Sending Mail'
                // Do the functionality for email reset
                render(view: 'home')
            }
        }
    }

    def logout(){
        println 'logout'
        session.invalidate();
//        Session session = sessionFactory.currectsession
//
//        session.flush()
//        session.clear()
        redirect url: '/'
    }
}
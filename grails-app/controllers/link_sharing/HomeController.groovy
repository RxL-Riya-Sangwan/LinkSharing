package link_sharing

import grails.converters.JSON
import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile
import org.hibernate.SessionFactory

class HomeController {

    static allowedMethods = ['index': 'GET', 'login': ['GET', 'POST'], 'register': ['GET','POST'], forgotPassword: ['GET', 'POST']]

    def index(){
        render(view: 'home')
    }

    def register(){
        if (request.method == 'GET'){
            render(view: 'home')
        }
        else{

            UserData user1 = UserData.findByEmail(params.email)

            if(!user1.validate()){
                response.status = 404
                render([error: 'an error occurred'] as JSON)
            }

            if (user1){
                flash.message = 'Email already taken'
                render(view: 'login')
            }

            user1 = UserData.findByUsername(params.username)
            if(user1){
                flash.message = 'Username taken'
                render(view: 'login')
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

                if (newUser.hasErrors()){
                    println newUser.errors
                    render(view: 'home')
                }
                else if (newUser == null){
                    println 'Null Object'
                    render(view: 'home')
                }
                else{
                    newUser.save(failOnError: true, flush: true)
//                    session['id'] = newUser.getId()
                    session['username'] = newUser.getUsername();

                    response.status = 200
                    render(view: 'dashboard')
                }

            }
        }

    }

    @Transactional
    def login(){

        try{
            println 'login --check for session'
            SessionFactory.currentSession.flush()
            SessionFactory.currentSession.clear()
        }
        catch (e){
            println 'Not logged In'
        }

        if (request.method == 'GET'){
            render(view: 'login')
        }
        else{
            UserData user1 = UserData.findByUsername(params.username);

            if (!user1){
                user1 = UserData.findByEmail(params.username)
            }
            if (user1){
                if  (params.password == user1.password){
//                    session['id'] = user1.getId()
                    session['username'] = user1.getUsername()
                    println "${session['username']}"
                    render(view: 'dashboard')
                }
                else{
                    flash.message = 'Incorrect credentials'
                    render(view: 'forgotPassword')
                }
            }
            else{
                flash.message = "You're not registered yet!"
                render(view: 'home')
            }

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
        // Error --No such property: currentSession for class: org.hibernate.SessionFactory Possible solutions: currentSession
        SessionFactory.currentSession.flush()
        SessionFactory.currentSession.clear()
    }
}
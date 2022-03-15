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
        if (session['username']){

            UserData usr = UserData.findByUsername(session['username'])
            List <Topic> topicList = Topic.findAllByUserdata(usr)

            render(view: 'dashboard', model: [newUser: usr, topicList: topicList])
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

//                if (params.photo){
//                    MultipartFile file = params.photo as MultipartFile
//                    byte [] picture = file.getBytes();
//                    params.photo = picture

//                }

//                def f = request.getFile(params.photo)



//                String filename=f.getOriginalFilename(params.photo)

                println 'creating new object'
//                bindData(user1, params, [exclude: 'confirmPassword'])
                UserData newUser = new UserData(params)
                newUser.isActive = true
                newUser.isAdmin = false
//
//                if(!newUser.validate()){
//                    println 'validating'
//                    response.status = 404
//                    flash.message = 'Issues with Validation!'
//                    render(view: 'home')
//                }
//                else if (newUser.hasErrors()){
//                    println newUser.errors
//                    render(view: 'home')
//                }
//                else{

 //                    id is readOnly -- cannot be used
//                    session['id'] = newUser.getId()
                    session['username'] = newUser.getUsername()
                    if (newUser.isAdmin){
                        session['role'] = 'admin'
                    }
                    else{
                        session['role'] = 'notAdmin'
                    }

//
//                    MultipartFile f = request.getFile(params.photo)
//
//                    if (!f.empty) {
//                            String filePath = '/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/images/UserImage/' + session['username']
//                    }
//
//                    f.tranferTo(new File(filePath))
                    def f = request.getFile(params.photo)

//                    String filename=f.getOriginalFilename()
                    String filePath = '/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/images/UserImage/' + session['username']


//                    String loc='/grails-app/assets/documents/'+ username + filename

                    File des = new File(filePath)

                    f.transferTo(des)
//
//                    String url=username+filename
//
//                    DocumentResource dr=newDocumentResource(documentPath: url , description:descrip

                    newUser.save(failOnError: true, flush: true)

                    response.status = 200

//                    List <Subscription> li1 = Subscription.findAllByUserdata(newUser)


                    UserData usr = UserData.findByUsername(session['username'])
                    List <Topic> topicList = Topic.findAllByUserdata(usr)

                    render(view: 'dashboard', model: [newUser: newUser, topicList: topicList])


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
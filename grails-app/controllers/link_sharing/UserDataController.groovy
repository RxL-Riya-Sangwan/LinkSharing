package link_sharing

import org.springframework.web.multipart.MultipartFile
import grails.transaction.Transactional


class UserDataController {

    def homeService

    def profile(){

        if (!session['username'])
        {
            flash.warning = "You are not logged In"
            redirect(controller: 'home', action: 'index')
        }
        else
        {
            UserData usr = UserData.findByUsername(params.username)

            if(!usr){
                usr = UserData.findByUsername(session['username'])
            }

            List <Topic> topicList = Topic.findAllByCreatedBy(usr)
            List <Subscription> subscriptionList = Subscription.findAllByUserdata(usr);
            List <ResourceData> resourceDataList = ResourceData.findAllByCreatedBy(usr);
            List li = [topicList, subscriptionList, resourceDataList];

            for(List list in li){
                if(list.isEmpty()){
                    list = []
                }
            }
            render(view: 'profile', model: [topicList: topicList, subscriptionList: subscriptionList, resourceDataList: resourceDataList, usr: usr])
        }

    }

    def edit()
    {
        if (!session['username'])
        {
            flash.warning = "You are not logged In"
            redirect(controller: 'home', action: 'index')
        }
        else
        {
            UserData usr = UserData.findByUsername(session['username'])
            List <Topic> topicList = Topic.findAllByCreatedBy(usr)
            render(view: 'userprofile', model: [topicList: topicList, usr: usr])
        }
    }


    def updateProfile(){

        UserData usr = UserData.findByUsername(session.username)

        UserData existingUser = UserData.findByUsername(params.username)

        if (existingUser && existingUser != usr){
            flash.warning = "Username already taken"
            redirect(action: 'edit')
        }
        else
        {
            usr.firstName = params.firstName
            usr.lastName = params.lastName
            usr.username = params.username

            if (!usr.validate())
            {
                usr.errors.allErrors.each {
                    println it
                }
            }
            else
            {
                usr.save(failOnError: true, flush: true)
                flash.message = "Your information is Updated!"
                redirect(controller: 'home', action: 'login')
            }
        }
    }


    def updatePassword(){

        println 'Inside updatePassword'

        UserData usr = UserData.findByUsername(session.username)

        if (params.password != params.confirmPassword)
        {
            redirect(controller: 'userData', action: 'edit')
        }
        else if (params.password.length() < 8){

            redirect(controller: 'userData', action: 'edit')

        }
        else
        {
            println 'updating password'
            usr.password = params.password
            usr.save(failOnError: true, flush: true)
            flash.message = "Your information is Updated!"
            redirect(controller: 'home', action: 'login')
        }

    }

    def updateStatus(){
        UserData usr = UserData.findById(params.userId);

        if(!usr.isAdmin){
            if (usr.isActive){
                usr.isActive = false
            }
            else{
                usr.isActive = true
            }
        }
        else{
            flash.message = "You can't deactivate admin user"
            redirect(controller: 'home', action: 'index')
        }

        println 'updating active status'
        usr.save(failOnError: true, flush: true)

    }
}

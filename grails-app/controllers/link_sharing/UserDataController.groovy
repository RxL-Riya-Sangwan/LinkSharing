package link_sharing

import org.springframework.web.multipart.MultipartFile
import grails.transaction.Transactional

class UserDataController {


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

    def show(){

    }
}

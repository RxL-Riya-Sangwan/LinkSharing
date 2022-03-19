package link_sharing

import org.springframework.web.multipart.MultipartFile
import grails.transaction.Transactional

class UserDataController {


    def profile(){
        UserData usr = UserData.findByUsername(session['username'])
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

    def show(){

    }
}

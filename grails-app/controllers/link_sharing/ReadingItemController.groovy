package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReadingItemController {

    def show()
    {

        UserData usr = UserData.findByUsername(session['username'])
        List <Subscription> subList = Subscription.findAllByUserdata(usr)
        List <ResourceData> readingList = []
        for(Subscription sub in subList)
        {
            List <ResourceData> posts = ResourceData.findAllByTopic(sub.topic)
            for(ResourceData post in posts)
            {
                readingList.add(post)
            }
        }


        render(view: 'show', model: [readingList: readingList])

    }

    def remove() {

        UserData usr = UserData.findByUsername(session['username'])
        ResourceData resourceData = ResourceData.findById(params.postId)
        ReadingItem item = ReadingItem.findByUserdataAndResourcedata(usr, resourceData)

        item.isRead = true
        item.save(flush: true, failOnError: true)
        flash.message = "You have read a post!!"
        redirect(controller: 'home', action: 'index')

    }

    def add(){

    }

}
package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TopicController {

    static allowedMethods = ['create': ['GET', 'POST']]

    def create(){
        // Check if this topic name already exists for user
            UserData usr = UserData.findByUsername(session['username'])
            Topic newTopic = Topic.findByNameAndCreatedBy(params.name, usr)
//            Topic newTopic = Topic.findByUserdataAndName(usr, params.name)

            if (newTopic){
                println 'same name topic'
                flash.message = 'Topic with same name cannot be created'
                redirect(action: 'show')

            }else{
                println 'creating topic'
                println params
                Topic topic = new Topic(params);
                // Why it's not binding name and date automatically??
//                topic.name = params.name
//                topic.userdata = usr
//                topic.dateCreated = new Date()
//                topic.lastUpdated = new Date()

//                topic.createdBy(usr)
                usr.addToTopics(topic)
                println "${topic.properties}"

                if(!topic.validate()){
                    println 'validating'
                    response.status = 404
                    flash.message = 'Issues with Validation!'
                    redirect(action: 'show')
                }
                else if (topic == null){
                    println 'Null Object'
                    redirect(action: 'show')
                }
                else if (topic.hasErrors()){
                    println topic.errors
                    redirect(action: 'show')
                }
                else{
                    topic.save(flush:true, failOnError: true)
                    flash.message = "${topic.name} Created!"
                    redirect(action: 'show')
                }

            }
    }

    def show(params){
        UserData usr = UserData.findByUsername(session['username'])
        List <Topic> topicList = Topic.findAllByCreatedBy(usr)
        if (!topicList){
            topicList = []
        }
        render(view: 'showTopic', model: [topicList: topicList])
    }
}


package link_sharing


import grails.transaction.Transactional

@Transactional(readOnly = true)
class TopicController {

    static allowedMethods = ['create': ['GET', 'POST'], 'show': ['GET']]

    def create(){

            UserData usr = UserData.findByUsername(session['username'])
            Topic newTopic = Topic.findByNameAndCreatedBy(params.name, usr)

            if (newTopic){
                println 'same name topic'
                flash.message = 'Topic with same name cannot be created'
                redirect(action: 'show')

            }else{
                println 'creating topic'

                Topic topic = new Topic(params);
                usr.addToTopics(topic)

                if(!topic.validate()){
                    println 'validating'
                    if(topic.hasErrors()){
                        topic.errors.allErrors.each{
                            println(it)
                        }
                    }
                    response.status = 404
                    println 'Issues with Validation!'
                    redirect(action: 'show')
                }
                else{
                    topic.save(flush:true, failOnError: true)
                    flash.message = "${topic.name} Created!"
                    redirect(action: 'show')
                }

            }

    }

    def show(){

        UserData usr = UserData.findByUsername(session['username'])
        List <Topic> topicList = Topic.findAllByCreatedBy(usr)
        if (!topicList){
            topicList = []
        }
        render(view: 'show', model: [topicList: topicList])
    }
}


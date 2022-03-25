package link_sharing


import grails.transaction.Transactional


@Transactional(readOnly = true)
class TopicController {

    def mailService

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
                    usr.addToTopics(topic)
                    Subscription newSub = new Subscription();
                    topic.addToSubscription(newSub)
                    usr.addToSubscription(newSub)
                    newSub.seriousness = Seriousness.VerySerious;

                    newSub.save(flush: true, failOnError: true)

                    flash.message = "${topic.name} Created!"
                    redirect(action: 'show')
                }

            }

    }

    def show(){

        UserData usr = UserData.findByUsername(session['username'])
        List <Topic> topicList = Topic.findAll()
        if (!topicList){
            topicList = []
        }
        render(view: 'show', model: [topicList: topicList])
    }

    def topicShow(){

        if (!session['username'])
        {
            redirect(controller: 'home', action: 'index')
        }
        else
        {
            Topic topic = Topic.findByName(params.topicName)

            List <ResourceData> resourceDataList = ResourceData.findAllByTopic(topic)
            List <Subscription> subList = Subscription.findAllByTopic(topic)

            render(view: 'topicShow', model: [resourceDataList: resourceDataList, usersList: subList, topic: topic])
        }

    }

    def list(){
        UserData usr = UserData.findByUsername(session['username'])
        List <Topic> topicList = Topic.findAllByCreatedBy(usr)
        if (!topicList){
            topicList = []
        }
        render(view: 'show', model: [topicList: topicList])
    }

    def delete(){

        UserData usr = UserData.findByUsername(session['username'])
        Topic topic = Topic.findById(params.topicId)


        if (topic.createdBy == usr || usr.isAdmin)
        {
            if(topic.createdBy == usr){
                usr.removeFromTopics(topic)
            }
        }

        topic.delete(flush: true, failOnError: true)
        println 'topic is deleted'
        flash.warning = "Topic is deleted"
        redirect(controller: 'home', action: 'index')

    }


    def sendInvite(){

        UserData usr = UserData.findByUsername(session['username'])

        mailService.sendMail {
            to params.email
            from "riasangwan1999@gmail.com"
//            cc "marge@gmail.com", "ed@gmail.com"
//            bcc "joe@gmail.com"
            subject "You're Invited!"
            text "Subscribe to ${params.topic}"
        }

        flash.message = "Your invitation mail have been sent!"
        redirect(controller: 'home', action: 'index')

    }


    def edit(){
        println params
        Topic topic = Topic.findById(params.topicId)
        topic.name

    }

    def setVisibility(){

        Topic topic = Topic.findById(params.topicId)

        if (params.visibility == 'Private'){
            topic.visibility = Visibility.Private
        }
        else{
            topic.visibility = Visibility.Public
        }

        topic.save(flush: true, failOnError: true)

    }

}


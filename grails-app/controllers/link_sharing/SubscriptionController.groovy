package link_sharing


import grails.transaction.Transactional

@Transactional(readOnly = true)
class SubscriptionController {

    static allowedMethods = ['create': ['GET', 'POST'], 'show': ['GET']]

    def subscribe(){

        Subscription newSub = new Subscription();
        Topic topic = Topic.findByName(params.topic)
        UserData usr = UserData.findByUsername(params.username)
        topic.addToSubscription(newSub)
        usr.addToSubscription(newSub)

        // Right now ..it's very serious ..but it should take from user
        newSub.seriousness = Seriousness.VerySerious;

        if(!newSub.validate()){
            println 'validating'
            if(newSub.hasErrors()){
                newSub.errors.allErrors.each{
                    println(it)
                }
            }
            response.status = 404
            println 'Issues with Validation!'
//            redirect(action: 'show')
            redirect(controller: 'home', action: 'index')

        }
        else{

            newSub.save(flush:true, failOnError: true)

            flash.message = "You're subscribed to ${topic.name} topic."
//            redirect(action: 'show')
            redirect(controller: 'home', action: 'index')
        }


    }

    def unsubscribe(){

        Subscription sub = Subscription.get(params.subscription)
        Topic topic = Topic.findByName(params.topic)
        UserData usr = UserData.findByUsername(params.username)

        if (topic.createdBy == usr){
            flash.message = "You can't unsubscribe to your own topic";
            redirect(controller: 'home', action: 'index')
        }
        else{
            topic.removeFromSubscription(sub)
            usr.removeFromSubscription(sub)


            sub.delete(flush:true, failOnError: true)

            flash.message = "You're unsubscribed to ${topic.name} topic."

            redirect(controller: 'home', action: 'index')
        }

    }

    def show()
    {
        UserData usr = UserData.findByUsername(session['username'])
        List <Subscription> subList = Subscription.findAllByUserdata(usr)
        render(view: 'show', model:[subList: subList])
    }


    def setSeriousness(){

        Topic topic = Topic.findById(params.topicId)
        UserData usr = UserData.findByUsername(session['username'])
        Subscription sub = Subscription.findByTopic(topic)
        if (params.seriousness == 'Serious'){
            sub.seriousness = Seriousness.Serious;
        }
        else if(params.seriousness == 'Very Serious'){
            sub.seriousness = Seriousness.VerySerious
        }
        else{
            sub.seriousness = Seriousness.Casual
        }


        sub.save(flush: true, failOnError: true)

    }

}


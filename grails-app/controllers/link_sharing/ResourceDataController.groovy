package link_sharing


import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceDataController {

    static allowedMethods = ['createLink': ['POST', 'GET'], 'createDocument': ['get', 'post']]

    def createLink(){

        UserData usr = UserData.findByUsername(session['username'])
        LinkResource newResource = new LinkResource()
        bindData(newResource,params, [exclude: ['topic']])
        usr.addToResourcedata(newResource)
        Topic topic = Topic.findByName(params.topic)
        topic.addToResourcedata(newResource)

        List <Subscription> subscribers = Subscription.findAllByTopic(topic)

        ReadingItem newItem;

        for (Subscription sub in subscribers){

            newItem = new ReadingItem()
            sub.userdata.addToReadingitem(newItem)
            newResource.addToReadingitem(newItem)
            newItem.isRead = false
        }

        if(!newResource.validate()){
            println 'validating'
            response.status = 404
            if (newResource.hasErrors()){
                newResource.errors.allErrors.each {
                    println it
                }
            }
            flash.message = 'Issues with Validation!'
            redirect(action: 'show')
        }
        else{

            newResource.save(failOnError: true, flush: true)
            flash.message = "Link Resource Created!"
            redirect(action: 'show')
        }

        newItem.save(flush: true, failOnError: true)

    }

    def createDocument(){

        def f = request.getFile('file')
        Integer count = 1;
        UserData usr = UserData.findByUsername(session['username'])
        f.transferTo(new File("/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/${usr.username}${count.toString()}.pdf"))
        DocumentResource newResource = new DocumentResource()
        bindData(newResource,params, [exclude: ['topic', 'file']])
        usr.addToResourcedata(newResource)
        Topic topic = Topic.findByName(params.topic)
        topic.addToResourcedata(newResource)

        newResource.filePath = "/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/${usr.username}${count.toString()}.pdf"

        List <Subscription> subscribers = Subscription.findAllByTopic(topic)

        ReadingItem newItem;

        for (Subscription sub in subscribers){

            newItem = new ReadingItem()
            sub.userdata.addToReadingitem(newItem)
            newResource.addToReadingitem(newItem)
            newItem.isRead = false
        }

        if(!newResource.validate()){
            println 'validating'
            response.status = 404
            if(newResource.hasErrors()){
                newResource.errors.allErrors.each{
                    println it
                }
            }
            flash.message = 'Issues with Validation!'
            redirect(view: 'show')
        }

        else{
            newResource.save(failOnError: true, flush: true)
            flash.message = "Document Resource Created!"
            count++;
            redirect(action: 'show')
        }

        newItem.save(flush: true, failOnError: true)

    }

    def show(){

        UserData usr = UserData.findByUsername(session['username'])
        List <ResourceData> resourceList = ResourceData.findAllByCreatedBy(usr)

        if (!resourceList){
            resourceList= []
        }
        render(view: 'show', model: [resourceList: resourceList])
    }


    def delete(){

        UserData usr = UserData.findByUsername(session['username'])
        ResourceData resourceData = ResourceData.findById(params.postId)
        Topic topic = Topic.findByNameAndCreatedBy(resourceData.topic.name, usr)
        if (!topic){
            topic = Topic.findByName(resourceData.topic.name)
        }

        if (resourceData.createdBy == usr || usr.isAdmin)
        {
            topic.removeFromResourcedata(resourceData)
            if(resourceData.createdBy == usr)
            {
                usr.removeFromResourcedata(resourceData)
            }
        }

        resourceData.delete(flush: true, failOnError: true)
        flash.warning = "Post is deleted"
        redirect(controller: 'home', action: 'index')

    }

    def showPost(){

        if (!session['username'])
        {
            redirect(controller: 'home', action: 'index')
        }
        else
        {
            UserData usr = UserData.findByUsername(session['username'])
            ResourceData post = ResourceData.get(params.postId)
            List <ResourceRating> ratingList = ResourceRating.findAllByResourcedata(post)
            List <Subscription> subList = Subscription.findAllByUserdata(usr)

            if (!ratingList){
                ratingList = []
            }
            render(view: 'post', model: [post: post, ratingList: ratingList, subList: subList, rating: 4])
        }
    }
}

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

    }

    def createDocument(){

        def f = request.getFile('file')
        


        UserData usr = UserData.findByUsername(session['username'])
        f.transferTo(new File("/home/nitin/RiyaS/LinkSharing/grails-app/assets/${usr.username}.pdf"))
        DocumentResource newResource = new DocumentResource()
        bindData(newResource,params, [exclude: ['topic', 'file']])
        usr.addToResourcedata(newResource)
        Topic topic = Topic.findByName(params.topic)
        topic.addToResourcedata(newResource)

        newResource.filePath = "/home/nitin/RiyaS/LinkSharing/grails-app/assets/${usr.username}.pdf"

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
            redirect(action: 'show')
        }
    }

    def show(){

        UserData usr = UserData.findByUsername(session['username'])
//        Topic topic = Topic.findByName(params.topic)
        List <ResourceData> resourceList = ResourceData.findAllByCreatedBy(usr)
        if (!resourceList){
            resourceList= []
        }
        render(view: 'show', model: [resourceList: resourceList])
    }
}

package link_sharing

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceDataController {

    static allowedMethods = ['create': ['POST', 'GET']]

    def createLink(){
        println params

        UserData usr = UserData.findByUsername(session['username'])
        LinkResource newResource = new LinkResource()
        bindData(newResource,params, [exclude: ['topic']])
        usr.addToResourcedata(newResource)
        Topic topic = Topic.findByName(params.topic)
        topic.addToResourcedata(newResource)

        if(!newResource.validate()){
            println 'validating'
            response.status = 404
            flash.message = 'Issues with Validation!'
            redirect(action: 'show')
        }

        else if (newResource.hasErrors()){
            println topic.errors
            redirect(action: 'show')
        }
        else{
            newResource.save(failOnError: true, flush: true)
            flash.message = "Link Resource Created!"
            redirect(action: 'show')
        }

    }

    def createDocument(){
        Integer count = 1;
        println request
        println 1
        println request.getFile('filename')
        println 2
        def f = request.getFile('filename')
        println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."
        f.transferTo(new File('file4.pdf'))
        String des = 'DocumentResource/file' + count + '.pdf'
        f.transferTo(new File(des))

//        UserData usr = UserData.findByUsername(session['username'])
//        DocumentResource newResource = new DocumentResource()
//        bindData(newResource,params, [exclude: ['topic', 'filePath']])
//        usr.addToResourcedata(newResource)
//        Topic topic = Topic.findByName(params.topic)
//        topic.addToResourcedata(newResource)
//
//
//        println("params---->" + params)
//        String filename = params.filename
//        //byte[] f =  request.getFile("filename").inputStream.text
//        String filePath = '/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/images/DocumentResource/' + session['username'] + filename
////        println(filePath)
//        println f
//        File des = new File(filePath);
//        des.createNewFile()
//        f.tranferTo(des)
//        newResource.filePath = filePath
//
//        if(!newResource.validate()){
//            println 'validating'
//            response.status = 404
//            flash.message = 'Issues with Validation!'
//            redirect(action: 'show')
//        }
//
//        else if (newResource.hasErrors()){
//            println topic.errors
//            redirect(action: 'show')
//        }
//        else{
//            newResource.save(failOnError: true, flush: true)
//            flash.message = "Document Resource Created!"
//            redirect(action: 'show')
//        }
        render "yo"
    }

    def show(){

        UserData usr = UserData.findByUsername(session['username'])
        Topic topic = Topic.findByName(params.topic)
        List <ResourceData> resourceList = ResourceData.findAllByCreatedByAndTopic(usr, topic)
        if (!resourceList){
            resourceList= []
        }
        render(view: 'showResource', model: [resourceList: resourceList])
    }
}

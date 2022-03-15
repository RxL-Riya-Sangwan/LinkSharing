package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceDataController {

    static allowedMethods = ['create': ['POST', 'GET']]

    def create(params){
//            println "${params}"
        UserData usr = UserData.findByUsername(session['username'])

        ResourceData newResource = new ResourceData()
            newResource.description = params.description
            newResource.dateCreated = new Date()
            newResource.lastUpdated = new Date()
            newResource.topic = params.topic
            newResource.userdata = usr
           

            newResource.save(failOnError: true, flash: true)
    }
}

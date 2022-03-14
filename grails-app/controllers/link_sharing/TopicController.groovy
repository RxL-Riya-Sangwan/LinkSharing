package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TopicController {

//    static allowedMethods = ['create': ['GET', 'POST']]

    def create(){
//        println 'topic controller'
//


        println "Inside method"
        render (view:'create')
    }
}


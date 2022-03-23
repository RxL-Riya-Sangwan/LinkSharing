package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceRatingController {

    static allowedMethods = ['rate': ['GET', 'POST']]

    def rate(){
        println "Inside rate"
        println params

        ResourceRating newRating = new ResourceRating();
        UserData usr = UserData.findByUsername(params.username)
        usr.addToResourcerating(newRating)
        ResourceData resourceData = ResourceData.findById(params.postId)
        resourceData.addToResourcerating(newRating)
        newRating.score = params.count as Integer

        if(!newRating.validate()){
            println 'validating'
            if(newRating.hasErrors()){
                newRating.errors.allErrors.each{
                    println(it)
                }
            }
            response.status = 404
            println 'Issues with Validation!'
        }
        else{

            newRating.save(flush:true, failOnError: true)
            flash.message = "Post is rated!"

        }

    }

}


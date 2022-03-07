package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceRatingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ResourceRating.list(params), model:[resourceRatingCount: ResourceRating.count()]
    }

    def show(ResourceRating resourceRating) {
        respond resourceRating
    }

    def create() {
        respond new ResourceRating(params)
    }

    @Transactional
    def save(ResourceRating resourceRating) {
        if (resourceRating == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (resourceRating.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond resourceRating.errors, view:'create'
            return
        }

        resourceRating.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'resourceRating.label', default: 'ResourceRating'), resourceRating.id])
                redirect resourceRating
            }
            '*' { respond resourceRating, [status: CREATED] }
        }
    }

    def edit(ResourceRating resourceRating) {
        respond resourceRating
    }

    @Transactional
    def update(ResourceRating resourceRating) {
        if (resourceRating == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (resourceRating.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond resourceRating.errors, view:'edit'
            return
        }

        resourceRating.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'resourceRating.label', default: 'ResourceRating'), resourceRating.id])
                redirect resourceRating
            }
            '*'{ respond resourceRating, [status: OK] }
        }
    }

    @Transactional
    def delete(ResourceRating resourceRating) {

        if (resourceRating == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        resourceRating.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'resourceRating.label', default: 'ResourceRating'), resourceRating.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'resourceRating.label', default: 'ResourceRating'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

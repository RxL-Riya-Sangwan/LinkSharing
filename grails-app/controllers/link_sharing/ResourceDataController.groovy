package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResourceDataController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ResourceData.list(params), model:[resourceDataCount: ResourceData.count()]
    }

    def show(ResourceData resourceData) {
        respond resourceData
    }

    def create() {
        respond new ResourceData(params)
    }

    @Transactional
    def save(ResourceData resourceData) {
        if (resourceData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (resourceData.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond resourceData.errors, view:'create'
            return
        }

        resourceData.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'resourceData.label', default: 'ResourceData'), resourceData.id])
                redirect resourceData
            }
            '*' { respond resourceData, [status: CREATED] }
        }
    }

    def edit(ResourceData resourceData) {
        respond resourceData
    }

    @Transactional
    def update(ResourceData resourceData) {
        if (resourceData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (resourceData.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond resourceData.errors, view:'edit'
            return
        }

        resourceData.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'resourceData.label', default: 'ResourceData'), resourceData.id])
                redirect resourceData
            }
            '*'{ respond resourceData, [status: OK] }
        }
    }

    @Transactional
    def delete(ResourceData resourceData) {

        if (resourceData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        resourceData.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'resourceData.label', default: 'ResourceData'), resourceData.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'resourceData.label', default: 'ResourceData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

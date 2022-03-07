package link_sharing

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserDataController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UserData.list(params), model:[userDataCount: UserData.count()]
    }

    def show(UserData userData) {
        respond userData
    }

    def create() {
        respond new UserData(params)
    }

    @Transactional
    def save(UserData userData) {
        if (userData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userData.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userData.errors, view:'create'
            return
        }

        userData.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userData.label', default: 'UserData'), userData.id])
                redirect userData
            }
            '*' { respond userData, [status: CREATED] }
        }
    }

    def edit(UserData userData) {
        respond userData
    }

    @Transactional
    def update(UserData userData) {
        if (userData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userData.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userData.errors, view:'edit'
            return
        }

        userData.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userData.label', default: 'UserData'), userData.id])
                redirect userData
            }
            '*'{ respond userData, [status: OK] }
        }
    }

    @Transactional
    def delete(UserData userData) {

        if (userData == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        userData.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userData.label', default: 'UserData'), userData.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userData.label', default: 'UserData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

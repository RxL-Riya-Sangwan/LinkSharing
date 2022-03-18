package link_sharing

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile
import org.hibernate.Session


class Result{
    Integer code;
    String value;
    UserData user;
}



@Transactional
class HomeService {

//    def sessionFactory

    def getRegisterData(params, session) {

            Result res = new Result()

            UserData user1 = UserData.findByEmail(params.email)

            if (user1) {
                println 'Email taken'
                res.value = 'Email already taken'
                res.code = 1
            }

            user1 = UserData.findByUsername(params.username)

            if (user1) {
                println 'Username taken'
                res.value = 'Username already taken'
                res.code = 1
            }
            else if (params.password != params.confirmPassword) {

                res.value = 'Password do not match'
                res.code = 1

            }
            else {

                println 'creating new object'
                println params

                UserData newUser = new UserData(params)
                newUser.isActive = true
                newUser.isAdmin = false

                println 'validating'
                if (!newUser.validate()) {

                    res.code = 2
                    res.value = 'Issues with Validation!'
                    newUser.errors.allErrors.each {
                        println it
                    }
                }
                else{

                    session['username'] = newUser.getUsername()

                    if (newUser.isAdmin) {
                        session['role'] = 'admin'
                    } else {
                        session['role'] = 'notAdmin'
                    }

                    newUser.save(failOnError: true, flush: true)
                    res.value = 'You are successfully registered!'
                    res.code = 0

                    return res
                }
            }

    }


    def getLoginData(params, session){

        Result res =  new Result()

        UserData user1 = UserData.findByUsername(params.username)

        if (!user1){
            user1 = UserData.findByEmail(params.username)
        }

        if(!user1){
            res.code = 404
            res.value = "Email/Username Not Found"
            return res
        }
        else{
                if (params.password == user1.password){

                    session.username = user1.getUsername()

                    if (user1.isAdmin)
                    {
                        session.role = 'admin'
                    }
                    else
                    {
                        session.role = 'notAdmin'
                    }

                    println "${session.username}"
                    res.code = 200
                    res.value = 'Success'
                    res.user = user1
                    return res
                }
                else {
                    println 'Incorrect credentials'
                    res.code = 401
                    res.value = "Incorrect credentials! Forgot Password?"
                    return res
                }
        }

    }


}

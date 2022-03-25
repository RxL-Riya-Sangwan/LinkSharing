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

    def getRegisterData(params, session, request)
    {
            Result res = new Result()
            UserData user1 = UserData.findByEmail(params.email)

            if (user1)
            {
                res.value = 'Email already taken'
                res.code = 1
                return res
            }

            user1 = UserData.findByUsername(params.username)

            if (user1)
            {
                res.value = 'Username already taken'
                res.code = 1
                return res
            }
            else if (params.password != params.confirmPassword)
            {
                res.value = 'Password do not match'
                res.code = 1
                return res
            }
            else if (params.password.length() < 8){

                res.value = 'Password should be of size >= 8'
                res.code = 1
                return res
            }
            else
            {
                UserData newUser = new UserData(params)
                newUser.isActive = true
                newUser.isAdmin = false

                // Picture Upload
                println request
                def f = request.getFile('file')
                Integer count = 1;

                f.transferTo(new File("/home/rxogix/Documents/SessionII/Link_Sharing/grails-app/assets/${count.toString()}${newUser.username}"))
                newUser.photo = "${count.toString()}${newUser.username}"


                if (!newUser.validate())
                {
                    res.code = 2
                    res.value = 'Issues with Validation!'
                    newUser.errors.allErrors.each {
                        println it
                    }
                }
                else
                {
                    session['username'] = newUser.getUsername()

                    if (newUser.isAdmin)
                    {
                        session['role'] = 'admin'
                    } else
                    {
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
        else
        {
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

                    res.code = 200
                    res.value = "You're logged In"
                    res.user = user1
                    return res
                }
                else
                {
                    res.code = 401
                    res.value = "Incorrect credentials! Forgot Password?"
                    return res
                }
        }

    }


}

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

    def sessionFactory

    def registerUser(params) {



    }

    def getloginData(params, session){

        Result res =  new Result();

        UserData user1 = UserData.findByUsername(params.username);
        res.code = 402
        res.value = 'Username Taken'


        if (!user1){
            user1 = UserData.findByEmail(params.username)
            res.value = 'Email Taken'
            return res
        }
        if (user1){
                if  (params.password == user1.password)
                {
//                    session['id'] = user1.getId() -- read only property
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
                    res.value = 'Incorrect credentials'
                    return res

            }
        }
        else{
            println 'You are not registered'
            res.code = 404
            res.value = 'Username/Email Not Found'
            return res
        }

    }
}

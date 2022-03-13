package link_sharing

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class HomeService {

    def registerUser(params) {

        if (params.photo){
            MultipartFile file = params.photo as MultipartFile
            byte [] picture = file.getBytes();
            params.photo = picture
        }

        println 'creating new object'
//     bindData(user1, params, [exclude: 'confirmPassword'])

        UserData newUser = new UserData(params)

        if (newUser.hasErrors()){
            println newUser.errors
//            render(view: 'home')
        }
        else if (newUser == null){
            println 'Null Object'
//            render(view: 'home')
        }
        else{
            newUser.save(failOnError: true, flush: true)
        }

        return newUser

    }
}

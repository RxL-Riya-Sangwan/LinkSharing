package link_sharing

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')

//        "/forgotPassword"(controller: 'home', action: 'forgotPassword')
//        "/userTable"(controller: 'home', action: 'userTable')


        "/user/dashboard"(controller: 'home', action: 'dashboard')
//        "/user/profile/$id?"(controller: 'userData', action: 'profile')
//        "/user/show/$id?"(controller: 'userData', action: 'show')



        "500"(view:'/error')
        "404"(view:'/notFound')
//
        }


}

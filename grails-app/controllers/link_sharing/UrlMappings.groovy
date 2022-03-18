package link_sharing

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

         "/register"(controller: 'home', action: 'register')

        }


}

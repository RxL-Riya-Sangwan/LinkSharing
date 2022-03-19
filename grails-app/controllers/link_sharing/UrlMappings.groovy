package link_sharing

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

         "/"(controller: 'home', action: 'index')

        }


}

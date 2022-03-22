package link_sharing

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import groovy.mock.interceptor.MockFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(HomeController)
@Mock([UserData])
class HomeControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }

//    void "testLoginService"(){
//        given:
//            params.username = 'riya'
//            params.password = 12345678
//            session.username = 'riya'
//
//        def mockHomeService = new MockFor(homeService)
//        mockHomeService.demand.getLoginData(0..1){->
//            return []
//        }
//        controller.homeService = mockHomeService.proxyInstance()
//
//    }
}

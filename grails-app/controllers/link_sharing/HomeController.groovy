package link_sharing

class HomeController {

    static allowedMethods = ['index': 'GET', 'login': 'POST', 'register': 'POST', forgotPassword: ['GET', 'POST']]

    def index() {
        render(view: 'home')
    }

    def login(){
        // When user enter credentials and press login
        // Do the logic to check the credentials and allow user to enter accordingly --- server side / client side ??

        // If they are correct ->
        redirect(controller: 'UserData', action: 'profile');

        //If not ->
        redirect(controller: 'home', action: 'index');

    }

    def register(){
        // When user enter credentials and press Register
        // Do the logic to check the credentials constraints and allow user to enter accordingly

        // If they are correct ->
        // Create User , and then enter their newly formed profile
        redirect(controller: 'UserData', action: 'profile');

        //If not ->
        redirect(controller: 'home', action: 'index');
    }

    def forgotPassword(){
        // When clicked on forgot password
        render(view: 'forgotPassword')

        // again when user enter credentials and press submit
        // Do the logic to check the credentials constraints and allow user to enter accordingly

        // If they are correct ->
        // Update the password and redirect to dashboard
        redirect(controller: 'UserData', action: 'profile');

        //If not ->
        redirect(controller: 'home', action: 'forgotPassword');
    }
}

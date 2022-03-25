package link_sharing


import grails.transaction.Transactional

class HomeController {

    def mailService

    static allowedMethods = ['index': 'GET', 'login': ['GET', 'POST'], 'register': ['GET','POST'], forgotPassword: ['GET', 'POST']]
    

    def homeService

//    def beforeInterceptor = [action: this.&auth(), except: ['login', 'register']]
//
//    private auth(){
//        if(!session['username']){
//            println 'In Auth'
//            redirect(controller: 'home', action: 'login')
//            return false
//        }
//
//    }

    def index(){

         if (!session['username'])
         {
             redirect(action: 'login')
         }
        else
         {
             UserData usr = UserData.findByUsername(session['username'])
             List <Topic> alltopicList = Topic.findAll()
             List <Subscription> usrSubList = Subscription.findAllByUserdata(usr)
             Integer countTopic = Topic.countByCreatedBy(usr)
             Integer countSub = Subscription.countByUserdata(usr)
             List <Subscription> subList = Subscription.findAllByUserdata(usr)
             def trending = ResourceData.createCriteria().list() {
                    projections {
                        groupProperty('topic')
                        count('id', 'topicCount')
                    }
                 order('topicCount', 'desc')
             }

             List <Topic> trendingList = []

             for(def li in trending)
             {
                 String name = li.getAt(0)
                 Topic topic = Topic.findByName(name)
                 trendingList.add(topic)
             }
//             String query = 'Select * from topic where name in (Select topic, count(*) as postCount from resourceData groupBy topic orderBy postCount desc limit 5'
//             String query = 'Select topic_id, count(*) as postCount from resource_Data group By topic_id order By postCount desc;'

             List li = [alltopicList, subList]
             for (List li1 in li){
                 if (!li1){
                     li1 = []
                 }
             }

             alltopicList.unique()
             subList.unique()

             List <ResourceData> readingList = []
             for(Subscription sub in subList)
             {
                 List <ResourceData> posts = ResourceData.findAllByTopic(sub.topic)
                 for(ResourceData post in posts)
                 {
                     readingList.add(post)
                 }
             }

             readingList.unique()

             render(view: 'dashboard', model: [usrSubList: usrSubList, newUser: usr, topicList: alltopicList, subList: subList,trendingList: trendingList, readingList: readingList, countTopic: countTopic, countSub: countSub])
         }
    }

    @Transactional
    def register() {
        if (request.method == 'GET')
        {
            render(view: 'register')
        }
        else
        {
            Result res = homeService.getRegisterData(params, session, request)
            if (res.code == 1)
            {
                flash.warning = res.value
                redirect(action: 'login')
            }
            else if (res.code == 2)
            {
                flash.warning = res.value
                redirect(controller: 'home', action: 'apology')
            }
            else
            {
                flash.message = res.value
                redirect(action: 'index')
            }
        }

    }

    @Transactional
    def login(){
        if (request.method == 'GET'){

            // Recent shares -- also integrate with the ajax call that fetch every min, to show recent shares
            List <ResourceData> recentShares = ResourceData.createCriteria().list(max: 5){
                'topic'{
                    eq('visibility', Visibility.Public)
                }
                order('dateCreated', 'desc')
            }


            // Top posts -- also integrate with the ajax call that fetch every day
            List <ResourceData> topPosts = ResourceData.createCriteria().list (max: 5){
                'topic'{
                    eq('visibility', Visibility.Public)
                }
                order('resourcerating', 'desc')
            }

            render(view: 'home', model: [recentShares: recentShares, topPosts: topPosts])
        }
        else
        {
                Result result  = homeService.getLoginData(params, session)

                if(result.code == 404)
                {
                    flash.warning = result.value
                    redirect(action: 'register')

                }
                else if (result.code == 401)
                {
                    flash.warning = result.value
                    redirect(action: 'forgotPassword')
                }
                else
                {
                    flash.message = result.value
                    redirect(controller: 'home', action:'index')
                }
        }
    }

    @Transactional
    def forgotPassword(){
        if (request.method == 'GET')
        {
            render(view: 'forgotPassword')
        }
        else
        {

            println params

            if (!UserData.findByEmail(params.email))
            {
                flash.warning = "Account with '${params.email}' is not registered"
                render(view: 'home')
            }
            else
            {
                println 'Sending Mail'

                UserData adminUser = UserData.findByIsAdmin(true)
                UserData currentUser = UserData.findByEmail(params.email)

                mailService.sendMail {
                    to 'riya.sangwan@rxlogix.com'
                    from 'riasangwan1999@gmail.com'
                    subject 'Password Reset'
                    text  "Your password is ${currentUser.password}"
                }

                flash.message = "Check your registered mail for password"
                redirect(controller: 'home', action: 'index')
            }
        }
    }

    @Transactional
    def logout()
    {
        session.invalidate();
        flash.message = "You're logged out!"
        redirect(controller: 'home', action: 'login')
    }

    def apology()
    {
        render(view: 'apology')
    }

    def admin()
    {
        UserData currentUser = UserData.findByUsername(session['username'])
        if (!currentUser.isAdmin){
            flash.message = "You cannot access to this page!"
            redirect(controller: 'home', action: 'index')
        }
        else
        {
            List <UserData> userList = UserData.findAll()
            render(view: 'admin', model: [userList: userList])
        }

    }


    def search(String search){


        if (search != '' || session['role'] == 'admin')
        {
            UserData newUser = UserData.findByUsername(session['username'])

            // trending topics
            def trending = ResourceData.createCriteria().list() {
                projections {
                    groupProperty('topic')
                    count('id', 'topicCount')
                }
                order('topicCount', 'desc')
            }

            List <Topic> trendingList = []

            for(def li in trending)
            {
                String name = li.getAt(0)
                Topic topic = Topic.findByName(name)
                trendingList.add(topic)
            }


            // top posts
            List <ResourceData> topPosts = ResourceData.createCriteria().list (max: 5){
                'topic'{
                    eq('visibility', Visibility.Public)
                }
                order('resourcerating', 'desc')
            }

            // searched term related posts
            List <ResourceData> searchList = ResourceData.findAllByDescriptionIlike("%${search}%")

            List <Topic> topicList = Topic.findAllByNameIlike("%${search}%")

            for (Topic topic in topicList){
                searchList.addAll(ResourceData.findAllByTopic(topic))
            }


            println searchList

            if(!searchList){
                searchList = []
            }

            //pagination logic
            Integer max = 10;


            render(view: 'search', model: ['topPosts': topPosts, 'trendingList': trendingList, 'newUser': newUser, searchList: searchList, searchTerm: search])

        }
        else{
            flash.message = 'Not search term provided!'
            redirect(controller: 'home', action: 'index')
        }

    }

}
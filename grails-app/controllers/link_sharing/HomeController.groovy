package link_sharing


import grails.transaction.Transactional

class HomeController {

    static allowedMethods = ['index': 'GET', 'login': ['GET', 'POST'], 'register': ['GET','POST'], forgotPassword: ['GET', 'POST']]
    

    def homeService

    def beforeInterceptor = [action: this.&auth(), except: ['login', 'register']]

    private auth(){
        if(!session['username']){
            println 'In Auth'
            redirect(controller: 'home', action: 'login')
            return false
        }

    }

    def index(){

         if (!session['username'])
         {
             redirect(action: 'login')
         }
        else
         {
             UserData usr = UserData.findByUsername(session['username'])
             List <Topic> alltopicList = Topic.findAll()
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

             List <ResourceData> readingList = []
             for(Subscription sub in subList)
             {
                 List <ResourceData> posts = ResourceData.findAllByTopic(sub.topic)
                 for(ResourceData post in posts)
                 {
                     readingList.add(post)
                 }
             }

             println readingList

             render(view: 'dashboard', model: [newUser: usr, topicList: alltopicList, subList: subList,trendingList: trendingList, readingList: readingList])
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
            Result res = homeService.getRegisterData(params, session)
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
            if (!UserData.findByEmail(params.email))
            {
                flash.warning = "Account with '${params.email}' is not registered"
                render(view: 'home')
            }
            else
            {
                println 'Sending Mail'
                // Do the functionality for email reset
                render(view: 'home')
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

}
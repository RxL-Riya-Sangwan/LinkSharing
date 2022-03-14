package link_sharing

class BootStrap {

    def init = { servletContext ->


        UserData user1 = new UserData(email: "r@s.com", username: "riya", password: "12345678", firstName: "Riya", lastName: "Sangwan", isAdmin: true, isActive: true, dateCreated: new Date(), lastUpdated: new Date())
        UserData user2 = new UserData(email: "t@b.com", username: "tushar", password: "12345678", firstName: "Tushar", lastName: "Bhardwaj", isAdmin: false, isActive: true, dateCreated: new Date(), lastUpdated: new Date())
        UserData user3 = new UserData(email: "y@m.com", username: "yash", password: "12345678", firstName: "Yash", lastName: "Mohan", isAdmin: false, isActive: true, dateCreated: new Date(), lastUpdated: new Date())

        Topic topic1 = new Topic(name: "Javascript", lastUpdated: new Date(), dateCreated: new Date(), visibility: Visibility.Public)
        Topic topic2 = new Topic(name: "Java", lastUpdated: new Date(), dateCreated: new Date(), visibility: Visibility.Public)
        Topic topic3 = new Topic(name: "Ajax", lastUpdated: new Date(), dateCreated: new Date(), visibility: Visibility.Private)

        ResourceData res1 = new ResourceData(description: "belongs to javascript", lastUpdated: new Date(), dateCreated: new Date())
        ResourceData res2 = new ResourceData(description: "belongs to java", lastUpdated: new Date(), dateCreated: new Date())
        ResourceData res3 = new ResourceData(description: "belongs to ajax", lastUpdated: new Date(), dateCreated: new Date())
        ResourceData res4 = new ResourceData(description: "belongs to ajax", lastUpdated: new Date(), dateCreated: new Date())

        Subscription sub1 = new Subscription(dateCreated: new Date(), seriousness: Seriousness.VerySerious)
        Subscription sub2 = new Subscription(dateCreated: new Date(), seriousness: Seriousness.Casual)

        ReadingItem item1 = new ReadingItem(isRead: true)
        ReadingItem item2 = new ReadingItem(isRead: true)

        ResourceRating rating1 = new ResourceRating(score: 8)
        ResourceRating rating2 = new ResourceRating(score: 9)

//        DocumentResource doc1 = new DocumentResource( filePath: "/home/doc1.txt")
//        LinkResource doc2 = new LinkResource(url: "https://xyz.com/test1")


        // Topics <-> User Association
        user1.addToTopics(topic1)
        user1.save(failOnError:true,flush:true)
        topic1.save(failOnError:true,flush:true)
        user2.addToTopics(topic2).save(failOnError:true,flush:true)
        user3.addToTopics(topic3).save(failOnError:true,flush:true)


        // User, Topic <->  Resource Association
        user1.addToResourcedata(res1)
        topic1.addToResourcedata(res1)
        res1.save(failOnError:true,flush:true)
        user2.addToResourcedata(res2)
        topic2.addToResourcedata(res2)
        res2.save(failOnError:true,flush:true)
        user3.addToResourcedata(res3)
        topic3.addToResourcedata(res3)
        res3.save(failOnError:true,flush:true)
        user3.addToResourcedata(res4)
        topic3.addToResourcedata(res4)
        res3.save(failOnError:true,flush:true)

        // Link and Document (file Path) Resource <-> User, Topic Association
//        user1.addToResourcedata(doc1);
//        user2.addToResourcedata(doc2);
//        topic1.addToResourcedata(doc1);
//        topic2.addToResourcedata(doc2);
//        doc1.save(failOnError:true,flush:true)
//        doc2.save(failOnError:true,flush:true)

        // User, Topic <-> Subscription Association
        user1.addToSubscription(sub1);
        user2.addToSubscription(sub2);
        topic3.addToSubscription(sub1);
        topic3.addToSubscription(sub2);
        sub1.save(failOnError:true,flush:true);
        sub2.save(failOnError:true,flush:true);


        // User, Resource <-> Reading item Association
        user1.addToReadingitem(item1);
        user2.addToReadingitem(item2);
        res1.addToReadingitem(item1);
        res2.addToReadingitem(item2);
        item1.save(failOnError:true,flush:true);
        item2.save(failOnError:true,flush:true);


        // User, Resource <-> Resource Rating Association
        user1.addToResourcerating(rating1);
        user2.addToResourcerating(rating2);
        res1.addToResourcerating(rating1);
        res2.addToResourcerating(rating2);
        rating1.save(failOnError:true,flush:true)
        rating2.save(failOnError:true,flush:true)




















    }
    def destroy = {
    }
}

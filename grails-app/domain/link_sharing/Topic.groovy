package link_sharing

class Topic {
    String name;
//    UserData createdBy;
    Date lastUpdated;
    Date dateCreated;
    Visibility visibility;

    static hasMany = [subscription: Subscription, resourcedata: ResourceData];
    static belongsTo = [userdata: UserData];

    static constraints = {
//        name(unique: true)
    }
}

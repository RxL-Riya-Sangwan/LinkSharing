package link_sharing

class Topic {
    String name
//    UserData createdBy
    Date lastUpdated
    Date dateCreated
    Visibility visibility

    static hasMany = [subscription: Subscription, resourcedata: ResourceData];
    static belongsTo = [createdBy: UserData];

    static constraints = {
//        name(unique: true)
    }

    @Override
    String toString() {
        return name
    }
}

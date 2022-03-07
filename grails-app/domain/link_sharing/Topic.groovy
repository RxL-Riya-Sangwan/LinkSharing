package link_sharing

class Topic {
    String name;
    UserData createdBy;
    Date lastUpdated;
    Date dateCreated;
    Visibility visibility;

    static hasMany = [subs: Subscription, res: ResourceData];
    static belongsTo = [usr: UserData];

    static constraints = {
//        name(unique: true)
    }
}

package link_sharing

class Topic {
    String name;
//    UserData createdBy;  -- what is the need of this, if with belongTo we are crating a relation
    Date lastUpdated;
    Date dateCreated;
    Visibility visibility;

    static hasMany = [subs: Subscription, res: ResourceData];
    static belongsTo = [usr: UserData];

    static constraints = {
//        name(unique: true)
    }
}

package link_sharing

class ResourceData {
    String description;
    //UserData createdBy;
    //Topic topic;
    Date dateCreated;
    Date lastUpdated;

    static belongsTo = [topic: Topic, userdata: UserData]
    static hasMany = [readingitem: ReadingItem, resourcerating: ResourceRating]

    static constraints = {
    }
}

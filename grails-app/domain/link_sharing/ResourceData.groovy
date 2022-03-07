package link_sharing

class ResourceData {
    String description;
    UserData createdBy;
    Topic topic;
    Date dateCreated;
    Date lastUpdated;

    static belongsTo = [topic: Topic, usr: UserData]
    static hasMany = [readingItem: ReadingItem, link: LinkResource, docs: DocumentResource]

    static constraints = {
    }
}

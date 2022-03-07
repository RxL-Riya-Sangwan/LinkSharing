package link_sharing

class ReadingItem {
    ResourceData rsrc;
    UserData usr;
    Boolean isRead;

    static belongsTo = [usr: UserData, rsrc: ResourceData]

    static constraints = {
    }
}

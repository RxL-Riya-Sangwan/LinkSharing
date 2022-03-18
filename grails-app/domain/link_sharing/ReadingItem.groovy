package link_sharing

class ReadingItem {
    ResourceData resourcedata;
    UserData userdata;
    Boolean isRead;

    static belongsTo = [userdata: UserData, resourcedata: ResourceData]

    static constraints = {
    }
}

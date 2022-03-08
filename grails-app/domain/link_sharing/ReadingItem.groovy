package link_sharing

class ReadingItem {
//    ResourceData res;
//    UserData usr;
    Boolean isRead;

    static belongsTo = [userdata: UserData, resourcedata: ResourceData]

    static constraints = {
    }
}

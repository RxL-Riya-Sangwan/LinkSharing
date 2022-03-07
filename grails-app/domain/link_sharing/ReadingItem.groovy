package link_sharing

class ReadingItem {
//    ResourceData res;
//    UserData usr;
    Boolean isRead;

    static belongsTo = [usr: UserData, res: ResourceData]

    static constraints = {
    }
}

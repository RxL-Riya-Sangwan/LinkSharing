package link_sharing

class ResourceRating {
//    ResourceData res;
//    UserData usr;
    Integer score;

    static belongsTo = [userdata: UserData, resourcedata: ResourceData];

    static constraints = {
    }
}

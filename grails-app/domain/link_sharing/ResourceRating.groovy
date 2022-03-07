package link_sharing

class ResourceRating {
    ResourceData rsrc;
    UserData usr;
    Integer score;

    static belongsTo = [usr: UserData];

    static constraints = {
    }
}

package link_sharing

class ResourceRating {
    ResourceData res;
    UserData usr;
    Integer score;

    static belongsTo = [usr: UserData, resRating: ResourceRating];

    static constraints = {
    }
}

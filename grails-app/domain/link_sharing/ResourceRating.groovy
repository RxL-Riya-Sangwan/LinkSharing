package link_sharing

class ResourceRating {
    ResourceData resourcedata;
    UserData userdata;
    Integer score;

    static belongsTo = [userdata: UserData, resourcedata: ResourceData];

    static constraints = {
    }
}

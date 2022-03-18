package link_sharing


class Subscription {
    Topic topic;
    UserData userdata;
    Seriousness seriousness;
    Date dateCreated;

    static belongsTo = [userdata: UserData, topic: Topic];
    static constraints = {

    }
}

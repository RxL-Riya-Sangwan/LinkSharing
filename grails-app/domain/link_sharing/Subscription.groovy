package link_sharing


class Subscription {
    Topic topic;
    UserData user;
    Seriousness seriousness;
    Date dateCreated;

    static belongsTo = [usr: UserData, topic: Topic];
    static constraints = {

    }
}

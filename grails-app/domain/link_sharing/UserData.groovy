package link_sharing

class UserData {
    String email;
    String username;
    String password;
    String firstName;
    String lastName;
    Byte photo;
    Boolean isAdmin;
    Boolean isActive;
    Date dateCreated;
    Date lastUpdated;

    static hasMany = [topics: Topic, subs: Subscription, res: ResourceData, readingItem: ReadingItem, resRating: ResourceRating];

    static constraints = {
        username(unique: true)
        email(unique: true);
        photo(nullable: true, blank: true);
        password(minSize: 8);
    }

}

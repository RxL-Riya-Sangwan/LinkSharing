package link_sharing

class UserData {
    String email;
    String username;
    String password;
    String firstName;
    String lastName;
    String photo;
    Boolean isAdmin;
    Boolean isActive;
    Date dateCreated;
    Date lastUpdated;

    static hasMany = [topics: Topic, subscription: Subscription, resourcedata: ResourceData, readingitem: ReadingItem, resourcerating: ResourceRating];

    static constraints = {
        username(unique: true)
        email(unique: true);
//        photo(nullable: true, blank: true, maxSize: 1024 * 1024 * 25);
        password(minSize: 8);
        isAdmin(nullable: true)
        isActive(nullable: true)
        photo(nullable: true)
    }

    static mapping = {
//        isActive defaultValue: true;
    }

}

package link_sharing

class LinkResource {
    String url;

    static belongsTo = [rsrc: ResourceData];

    static constraints = {
    }
}

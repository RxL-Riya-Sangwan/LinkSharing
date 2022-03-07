package link_sharing

class DocumentResource {
    String filePath;

    static belongsTo = [rsrc: ResourceData];

    static constraints = {
    }
}

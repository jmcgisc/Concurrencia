import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let topic: Topic
    let details: TopicDetails
    
    init(from decoder: Decoder) throws {
        let rootObj = try decoder.singleValueContainer()
        topic = try rootObj.decode(Topic.self)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        details = try container.decode(TopicDetails.self, forKey: .details)
        
    }
    
}

struct TopicDetails: Codable {
    
    let canEdit: Bool?
    let canDelete: Bool?
    let canCreatePost: Bool?
    
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canCreatePost = "can_create_post"
    
    }
}

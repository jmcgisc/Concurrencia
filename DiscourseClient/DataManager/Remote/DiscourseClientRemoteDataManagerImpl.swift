//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) { 
        let request = UsersRequest(period: "all", order: "topic_count")
        self.session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchUser(user: User, completion: @escaping (Result<SingleUserResponse?, Error>) -> ()) {
        let request = SingleUserRequest(user: user)
        self.session.send(request: request) { result in
            completion(result)
        }
    }
    
    func changeUserName(user:User, completion: @escaping (Result<ChangeUserNameResponse?, Error>) -> ()) {
        let request = ChangeUserNameRequest(user: user)
        self.session.send(request: request) { result in
            completion(result)
        }
    }
}

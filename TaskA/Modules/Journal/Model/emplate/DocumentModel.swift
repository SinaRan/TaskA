//
//  JournalModel.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import Alamofire


struct DocumentModel {
    weak var delegate:DocumentPotocols?
    func fetchDocuments(){
        AF.request("http://api.plos.org/search?q=title:DNA").responseDecodable(of: DocumentModelTopLevel.self) { response in
            if response.error == nil {
                self.delegate?.didFetchDocuments(success: true, data: response.value!)
            }
            else {
                self.delegate?.didFetchDocuments(success: false, data: nil)
            }
            
        }
    }
}

struct DocumentModelTopLevel: Codable {
    let response: Response
}

struct Response: Codable {
    let numFound, start: Int?
    let maxScore: Double?
    let docs: [Doc]?
}

struct Doc: Codable {
    let id, journal, eissn, publicationDate: String?
    let articleType: String?
    let authorDisplay, abstract: [String]?
    let titleDisplay: String?
    let score: Double?

    enum CodingKeys: String, CodingKey {
        case id, journal, eissn
        case publicationDate = "publication_date"
        case articleType = "article_type"
        case authorDisplay = "author_display"
        case abstract
        case titleDisplay = "title_display"
        case score
    }
}

// MARK: Convenience initializers

extension DocumentModelTopLevel {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(DocumentModelTopLevel.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Response {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Response.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Doc {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Doc.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

//
//  DocumentInteractor.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation

class DocumentInteractor:DocumentPotocols {
    weak var delegate:DocumentPotocols?
    func fetchDocuments(){
        var model = DocumentModel()
        model.delegate = self
        model.fetchDocuments()
    }
    
    func didFetchDocuments(success: Bool, data: DocumentModelTopLevel?) {
        delegate?.didFetchDocuments(success: success, data: data)
    }
}

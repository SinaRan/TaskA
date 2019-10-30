//
//  DocumentsProtocol.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation

protocol DocumentPotocols:AnyObject {
    func didFetchDocuments(success:Bool, data:DocumentModelTopLevel?)
}

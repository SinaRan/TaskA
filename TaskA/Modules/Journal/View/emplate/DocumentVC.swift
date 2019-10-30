//
//  DocumentVC.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class DocumentVC: UIViewController,DocumentPotocols {
    let interactor = DocumentInteractor()
    override func viewDidLoad() {
        interactor.delegate = self
        interactor.fetchDocuments()
    }
    func didFetchDocuments(success: Bool, data: DocumentModelTopLevel?) {
        if success {
            print("done")
        }
    }
}

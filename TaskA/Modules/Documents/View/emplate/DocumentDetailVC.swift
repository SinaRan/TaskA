//
//  DocumentDetailVC.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class DocumentDetailVC: UIViewController {
    var doc: Doc!
    
    @IBOutlet weak var essinLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var journalLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var publicationDateLbl: UILabel!
    @IBOutlet weak var authorsLbl: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    
    
    override func viewDidLoad() {
        titleLbl.text = doc.titleDisplay
        essinLbl.text = "essin: \(doc.eissn ?? "")"
        journalLbl.text = "Journal: \(doc.journal ?? "")"
        typeLbl.text = "Type: \(doc.articleType ?? "")"
        publicationDateLbl.text = "\(doc.publicationDate ?? "")"
        do {
            try publicationDateLbl.setDate(text: "Publication Date: ")
        }catch{
            publicationDateLbl.text = "\(error)"
        }
        guard let authors = doc.authorDisplay else { return }
        var authorPlaceHolder = ""
        for i in authors.enumerated() {
            if i.offset == 0{
                authorPlaceHolder = "Authors: \(i.element)"
            }
            else {
                authorPlaceHolder = "\(authorPlaceHolder), \(i.element)"
            }
        }
        authorsLbl.text = authorPlaceHolder
        
        guard let abstracts = doc.abstract else { return }
        var abstract = ""
        for i in abstracts.enumerated() {
            if i.offset == 0{
                abstract = "\(i.element)"
            }
            else {
                abstract = "\(authorPlaceHolder), \(i.element)"
            }
        }
        abstractTextView.text = abstract
        abstractTextView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
}

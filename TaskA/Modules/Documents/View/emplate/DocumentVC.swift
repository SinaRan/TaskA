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
    
    @IBOutlet weak var table: UITableView!
    
    let interactor = DocumentInteractor()
    var data: DocumentModelTopLevel?
    
    var moreItems = [IndexPath]()
    
    var doc:Doc!
    override func viewDidLoad() {
        interactor.delegate = self
        interactor.fetchDocuments()
    }
    func didFetchDocuments(success: Bool, data: DocumentModelTopLevel?) {
        if success {
            self.data = data
            table.reloadData()
        }
    }
    @objc func seeMoreAction(_ sender: UIButton){
        let contain = moreItems.contains(sender.indexPath)
        if contain {
            moreItems.removeAll { (ind) -> Bool in
                if ind == sender.indexPath {
                    sender.setTitle("View More", for: UIControl.State.normal)
                    return true
                }
                else {
                    return false
                }
                
            }
        }
        else {
            sender.setTitle("View Less", for: UIControl.State.normal)
            moreItems.append(sender.indexPath)
        }
        table.beginUpdates()
        table.endUpdates()
    }
}

extension DocumentVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let docs = data?.response.docs else { return 0 }
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DocumentCell else { return UITableViewCell() }
        guard let item = data?.response.docs?[indexPath.row] else { return UITableViewCell()}
        cell.titleLbl.text = item.titleDisplay ?? ""
        cell.journalLbl.text = "Journal: \(item.journal ?? "")"
        cell.typeLbl.text = "Type: \(item.articleType ?? "")"
        cell.publicationDateLbl.text = "\(item.publicationDate ?? "")"
        do {
            try cell.publicationDateLbl.setDate(text: "Publication Date: ")
        }catch{
            cell.publicationDateLbl.text = "\(error)"
        }
        cell.viewMoreBtn.indexPath = indexPath
        cell.viewMoreBtn.addTarget(self, action: #selector(seeMoreAction), for: UIControl.Event.touchUpInside)
        
        let contain = moreItems.contains(indexPath)
        if contain {
            cell.viewMoreBtn.setTitle("View Less", for: UIControl.State.normal)
        }
        else {
            cell.viewMoreBtn.setTitle("View More", for: UIControl.State.normal)
        }
        guard let authorDispaly = item.authorDisplay else { return cell }
        if authorDispaly.count > 2 {
            cell.authorsLbl.text = "Authors: \(item.authorDisplay![0]), \(item.authorDisplay![1]) +\(item.authorDisplay!.count-2) more"
        }
        else {
            var authors = ""
            for (index, name) in authorDispaly.enumerated() {
                if index == 0 {
                    authors += "\(name), "
                }
                else {
                    authors += "\(name)"
                }
            }
            cell.authorsLbl.text = "Authors: \(authors)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let contain = moreItems.contains(indexPath)
        if contain {
            return 182
        }
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doc = data?.response.docs?[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DocumentDetailVC else { return }
        destination.doc = doc
    }

}

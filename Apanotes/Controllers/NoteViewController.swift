//
//  NoteViewController.swift
//  Apanotes
//
//  Created by Михаил Апанасенко 2 on 02.10.2021.
//

import UIKit
import PhotosUI

class NoteViewController: UIViewController {
    @IBOutlet weak var textField: UITextView!
    
    var notesManager: NotesManager?
    var index: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notesManager = notesManager, let index = index {
            textField.attributedText = NSMutableAttributedString(attributedString: notesManager.notes[index].content.attributedString)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            if let notesManager = notesManager, let index = index {
                notesManager.notes[index].content = AttributedString(textField.attributedText)
                notesManager.notes[index].date = notesManager.getDate()
                notesManager.saveData()
            }
        }
    }
}

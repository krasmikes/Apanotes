//
//  TableViewController.swift
//  Apanotes
//
//  Created by Михаил Апанасенко 2 on 02.10.2021.
//

import UIKit



class TableViewController: UITableViewController {
    @IBAction func newNotePressed(_ sender: UIBarButtonItem) {
        notesManager.notes.insert(Note(date: notesManager.getDate(), content: AttributedString(NSAttributedString(string: "Your new note!", attributes: notesManager.attributes))), at: 0)
        tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
    }
    
    let notesManager = NotesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Apanotes app"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let index = indexPath?.row ?? 0
        
        let noteViewController = segue.destination as! NoteViewController
        noteViewController.notesManager = notesManager
        noteViewController.index = index
    }

    
    
}

//MARK: - Table View Handling

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesManager.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notesManager.notes[indexPath.row].content.attributedString.string
        cell.detailTextLabel?.text = notesManager.notes[indexPath.row].date

        return cell
    }
    
    // this method handles row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            notesManager.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            notesManager.saveData()
            tableView.reloadData()

        }
    }
}


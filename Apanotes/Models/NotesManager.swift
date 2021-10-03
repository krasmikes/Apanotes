//
//  NotesManager.swift
//  Apanotes
//
//  Created by Михаил Апанасенко 2 on 02.10.2021.
//

import UIKit


class NotesManager {
    private let fileURL: URL
    var notes = [Note]()
    private let formatter = DateFormatter()
    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0)]
    
    init() {
        
        fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("ApanotesData.bin")
        if FileManager().fileExists(atPath: fileURL.path) {
            readData()
            print("Data readed: \(notes)")
        } else {
            let firstNote = Note(date: getDate(), content: AttributedString(NSAttributedString(string: "Your first note!", attributes: attributes)))
            notes.append(firstNote)
            saveData()
            print("File created, notes: \(notes)")
        }
    }
    
    func getDate () -> String {
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    func readData () {
        let readData = try! Data(contentsOf: fileURL)
        if let parsedNotes = try? JSONDecoder().decode([Note].self, from: readData) {
            notes.append(contentsOf: parsedNotes)
        }
    }
    
    func saveData () {
        let data = try! JSONEncoder().encode(notes)
        try! data.write(to: fileURL, options: [.completeFileProtection])
        print("Saved data")
    }
    
}

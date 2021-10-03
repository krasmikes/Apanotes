//
//  Note.swift
//  Apanotes
//
//  Created by Михаил Апанасенко 2 on 02.10.2021.
//

import Foundation

struct Note: Codable{
    var date: String
    var content: AttributedString
}

//обертка NSAttributedString в Codable взята отсюда: https://coderedirect.com/questions/383424/how-to-make-nsattributedstring-codable-compliant

class AttributedString : Codable {

    let attributedString : NSAttributedString

    init(_ nsAttributedString : NSAttributedString) {
        self.attributedString = nsAttributedString
    }

    public required init(from decoder: Decoder) throws {
        let singleContainer = try decoder.singleValueContainer()
        guard let attributedString = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(singleContainer.decode(Data.self)) as? NSAttributedString else {
            throw DecodingError.dataCorruptedError(in: singleContainer, debugDescription: "Data is corrupted")
        }
        self.attributedString = attributedString
    }

    public func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        try singleContainer.encode(NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: false))
    }
}

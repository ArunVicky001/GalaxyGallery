//
//  NetworkParser.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation
import SwiftyJSON

public protocol NetworkParser {
    init(from json: JSON) throws
}

public protocol StructuredParser: NetworkParser {}
public protocol UnstructuredParser: NetworkParser {}

struct StructuredParserData<T: NetworkParser> {
            
    let data: T
    
    init(from json: JSON) throws {
        self.data = try T(from: json)
    }
}

extension Array: NetworkParser, StructuredParser where Element: StructuredParser {
    public init(from json: JSON) {
        self = json.arrayValue.compactMap { try? Element(from: $0) }
    }
}


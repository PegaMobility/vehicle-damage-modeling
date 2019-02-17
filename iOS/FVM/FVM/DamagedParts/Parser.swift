//
//  Parser.swift
//  FVM
//
//  Created by Smykala, Szymon on 15/02/2019.
//  Copyright © 2019 Czajka, Kamil. All rights reserved.
//

import Foundation


protocol Parser{
    associatedtype type
    func parse(jsonData: String) -> type?
    func parse(Data: Data) -> type?
}

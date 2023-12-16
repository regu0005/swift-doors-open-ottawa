//
//  TruncateString.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-16.
//

func truncateString(_ string: String, toLength length: Int) -> String {
    if string.count > length {
        let index = string.index(string.startIndex, offsetBy: length)
        return String(string[..<index]) + "..."
    }
    return string
}

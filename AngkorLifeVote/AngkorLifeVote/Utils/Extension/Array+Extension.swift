//
//  Array+Extension.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        var currentChunk: [Element] = []
        
        for element in self {
            currentChunk.append(element)
            if currentChunk.count == size {
                chunks.append(currentChunk)
                currentChunk = []
            }
        }
        
        if !currentChunk.isEmpty {
            chunks.append(currentChunk)
        }
        
        return chunks
    }
}

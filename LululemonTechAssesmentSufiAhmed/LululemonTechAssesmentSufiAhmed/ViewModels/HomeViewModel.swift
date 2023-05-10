//
//  HomeViewModle.swift
//  LululemonTechAssesmentSufiAhmed
//
//  Created by Sufiyan Ahmed on 5/10/23.
//

import Foundation


class HomeViewModel {
    
    func sortedResults(segment: SegControl, array: [Garment]) -> [Garment] {
        
        var garments = array
        
        switch segment {
        case .alphabetic:
            garments.sort { $0.garmentName?.lowercased() ?? "" < $1.garmentName?.lowercased() ?? "" }
        case .date:
            garments.sort { $0.creationDate ?? Date() > $1.creationDate ?? Date()}
        }
        return garments
    }
    
}

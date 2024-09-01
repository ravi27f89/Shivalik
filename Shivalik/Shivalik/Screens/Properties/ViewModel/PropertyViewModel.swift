//
//  PropertyViewModel.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import Foundation

class PropertyViewModel {
    private let property: Property
    
    var title: String {
        return property.title
    }
    
    var description: String {
        return property.description
    }
    var image: String {
        return property.image
    }

    init(property: Property) {
        self.property = property
    }
}


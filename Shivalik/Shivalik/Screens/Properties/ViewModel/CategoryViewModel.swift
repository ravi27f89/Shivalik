//
//  CategoryViewModel.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import Foundation

class CategoryViewModel {
    private let category: Category
    
    var title: String {
        return category.title
    }
    var image: String {
        return category.image
    }

    init(category: Category) {
        self.category = category
    }
}

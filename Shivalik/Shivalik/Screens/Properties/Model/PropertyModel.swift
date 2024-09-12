import Foundation

// MARK: - PropertyModel
struct PropertyModel: Codable {
    let category: [Category]
    let property: [Property]
}

// MARK: - Category
struct Category: Identifiable,Codable {
    let id: Int
    let title: String
    let image: String
}

// MARK: - Property
struct Property: Identifiable, Codable {
    let id: Int
    let type: String
    let title: String
    let description: String
    let image: String
}

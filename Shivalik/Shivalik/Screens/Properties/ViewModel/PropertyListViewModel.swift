import Foundation

class PropertyListViewModel {
    private var properties: [Property] = []
    private var allProperties: [Property] = []
    private var categories: [Category] = []
        
    var numberOfCategories: Int {
        return categories.count
    }
    func categories(at index: Int) -> CategoryViewModel {
        return CategoryViewModel(category: categories[index])
    }
    
    func loadCategories() {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
             do {
                 let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                 categories = try JSONDecoder().decode([Category].self, from: data)
             } catch {
                 print("Error loading JSON data: \(error)")
             }
         }
    }
    
    var numberOfProperties: Int {
        return properties.count
    }

    func properties(at index: Int) -> PropertyViewModel {
        return PropertyViewModel(property: properties[index])
    }
    
    func loadProperties(at index: Int) {
       if let path = Bundle.main.path(forResource: "Properties", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let localProp = try JSONDecoder().decode([Property].self, from: data)
                properties = localProp.filter { $0.type == categories(at: index).title }
                allProperties = properties
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
    }
    
    func search(at str: String) {
        if !str.isEmpty{
            properties = allProperties.filter{ $0.title.contains(str.lowercased()) || $0.description.contains(str.lowercased())}
        }else{
            properties = allProperties
        }
    }
    
    var isEmptyArr: Bool {
        return properties.isEmpty
    }
    
    func fetchOccurance() -> String{
        var topOccurance = ""
        let arr = allProperties.map{$0.title}

        let combinedString = arr.joined().lowercased()
        var characterCount: [Character: Int] = [:]

        for char in combinedString {
            characterCount[char, default: 0] += 1
        }
        
        let sortedCharacters = characterCount.sorted { $0.value > $1.value }.prefix(3)
        for (char, count) in sortedCharacters {
            topOccurance = topOccurance + "\(char.uppercased()): \(count) \n"
        }

        return topOccurance
    }
}

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

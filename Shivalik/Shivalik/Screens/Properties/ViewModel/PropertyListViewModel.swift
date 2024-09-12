import Foundation

protocol PropertyViewModelDelegate: AnyObject {
    func didUpdateProperties()
    func didUpdateFilteredProperties()
}

class PropertyListViewModel {
    weak var delegate: PropertyViewModelDelegate?

    var response: PropertyModel?
    var selectedProperty: [Property] = []
    var filteredProperty: [Property] = []

    var searchText: String = "" {
        didSet {
            fetchSearchedItems()
        }
    }

    init() {
        fetchPropertyData()
    }
    
    func fetchProperty(at index: Int) {
        searchText = ""
        selectedProperty = self.response?.property.filter { $0.type == self.response?.category[index].title } ?? []
        delegate?.didUpdateProperties()
    }
    
    func fetchSearchedItems() {
        if !searchText.isEmpty {
            filteredProperty = selectedProperty.filter { item in
                item.title.lowercased().contains(searchText.lowercased()) ||
                item.description.lowercased().contains(searchText.lowercased())
            }
            delegate?.didUpdateFilteredProperties()
        }
    }
    
    func fetchOccurance() -> String {
        var topOccurance = ""
        let combinedString = selectedProperty.map { $0.title }.joined().lowercased()
        var characterCount: [Character: Int] = [:]

        for char in combinedString {
            characterCount[char, default: 0] += 1
        }
        
        let sortedCharacters = characterCount.sorted { $0.value > $1.value }.prefix(3)
        for (char, count) in sortedCharacters {
            topOccurance += "\(char.uppercased()): \(count) \n"
        }
        return topOccurance
    }

    private func fetchPropertyData() {
        DataLoader().loadData { [weak self] propertyModel in
            self?.response = propertyModel
            self?.delegate?.didUpdateProperties()
        }
    }
    
//    func search(at str: String, index: Int) {
//        selectedProperty = self.response?.property.filter { $0.type == self.response?.category[index].title } ?? []
//    }
    
    func search(at str: String, index: Int) {
        selectedProperty = self.response?.property.filter { $0.type == self.response?.category[index].title } ?? []
        searchText = str  // This will trigger fetchSearchedItems
        delegate?.didUpdateFilteredProperties()
    }

    /*
    var numberOfCategories: Int {
        return categories.count
    }
    func categories(at index: Int) -> CategoryViewModel {
        return CategoryViewModel(category: categories[index])
    }
    
    func fetchPropertyData(){
        
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
    }*/
}

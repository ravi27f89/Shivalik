import SwiftUI

class DataLoader {
    
    func loadData(completion: @escaping (PropertyModel) -> Void) {
        do {
            if let url = Bundle.main.url(forResource: "PropertyMockData", withExtension: "json"){
                let data = try Data(contentsOf: url)
                let model = try JSONDecoder().decode(PropertyModel.self, from: data)
                completion(model)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

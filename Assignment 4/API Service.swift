import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchQuote(forMood mood: String) async throws -> [Quote]? {
        guard let category = mood.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            //let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(category)") else {
            let url = URL(string: "https://api.api-ninjas.com/v1/quotes") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "X-Api-Key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let jsonStr = String(data: data, encoding: .utf8) {
            print("Raw JSON: \(jsonStr)")
        }
        
        do {
            print(data)
            let decodedQuotes = try JSONDecoder().decode([Quote].self, from: data)
            return decodedQuotes
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
}

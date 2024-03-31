import Foundation
import Alamofire

class NotesAPIController {
    
    private let baseURL = "http://apis.sakibnm.space:3000/api/note/"
    
    private func headers() -> HTTPHeaders {
        guard let token = AuthTokenManager.shared.retrieveToken() else {
            print("Authentication token is nil")
            return [:]
        }
        return ["x-access-token": token]
    }
    
    func getAll(completion: @escaping (Result<[NoteRes], Error>) -> Void) {
        AF.request(baseURL + "getall", headers: headers())
            .validate()
            .responseDecodable(of: NotesResponse.self) { response in
                switch response.result {
                case .success(let notesResponse):
                    completion(.success(notesResponse.notes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func addNote(text: String, completion: @escaping (Result<NoteResponse, Error>) -> Void) {
        let parameters: [String: String] = ["text": text]
        
        AF.request(baseURL + "post", method: .post, parameters: parameters, headers: headers())
            .validate()
            .responseDecodable(of: NoteResponse.self) { response in
                switch response.result {
                case .success(let noteResponse):
                    completion(.success(noteResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteNote(withId id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameters: [String: String] = ["id": id]
        
        let url = baseURL + "delete"
        
        AF.request(url, method: .post, parameters: parameters, headers: headers())
            .validate()
            .responseDecodable(of: DeleteNoteResponse.self) { response in
                print(response.result)
                switch response.result {
                case .success(let deleteResponse):
                    completion(.success(deleteResponse.delete))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
    // Response model for getting all notes
    struct NotesResponse: Codable {
        let notes: [NoteRes]
    }
    
    struct NoteRes: Codable {
        let userId: String
        let text: String
        let _id: String
        let __v: Int
    }

    // Response model for adding a note
    struct NoteResponse: Codable {
        let posted: Bool
        let note: NoteRes
    }

    // Response model for deleting a note
    struct DeleteNoteResponse: Codable {
        let delete: Bool
        let message: String
    }

}

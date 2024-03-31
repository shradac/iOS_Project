import Foundation
import Alamofire

class AuthAPIController {
    
    private let baseURL = "http://apis.sakibnm.space:3000/api/auth/"
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters: [String: String] = ["email": email, "password": password]
        
        AF.request(baseURL + "login", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    completion(.success(loginResponse.token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func register(name: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters: [String: String] = ["name": name, "email": email, "password": password]
        
        AF.request(baseURL + "register", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let registerResponse):
                    completion(.success(registerResponse.token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(baseURL + "logout", method: .get)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUserInfo(token: String, completion: @escaping (Result<UserInfoResponse, Error>) -> Void) {
        let headers: HTTPHeaders = ["x-access-token": token]
        
        AF.request(baseURL + "me", method: .get, headers: headers)
            .validate()
            .responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let userInfoResponse):
                    completion(.success(userInfoResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}

// Response models
struct LoginResponse: Codable {
    let auth: Bool
    let token: String
}

struct RegisterResponse: Codable {
    let auth: Bool
    let token: String
}

struct UserInfoResponse: Codable {
    let _id: String
    let name: String
    let email: String
    let __v: Int
}

//
//  ApiClient.swift
//  PlatedChallenge
//
//  Created by Bryan Dubay on 5/22/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation
import Alamofire

struct ApiClient {
    
    private static func performRequest<T: Decodable>( decodingType: T.Type, route:APIRouter, completion:@escaping ( Result<Any> ) -> Void ){
        Alamofire.request(route).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            do {
                print(String(data: response.data!, encoding: .utf8))
                let apiBase = try jsonDecoder.decode(decodingType, from: response.data!)
                completion(Result.success(apiBase as Any))
            }
            catch {
                completion(Result.failure(error))
            }
        }
    }
    
    static func getMenus(completion:@escaping (Result<Any>)->Void) {
        performRequest(decodingType:[Menu].self, route: APIRouter.menus, completion: completion)
    }
    static func getRecipes(with menuID:Int, completion:@escaping (Result<Any>)->Void ) {
        performRequest(decodingType: [Recipe].self, route: APIRouter.recipes(menuID: menuID), completion: completion)
    }
    
}

enum Parameters : String {
    case recipeForMenu
}

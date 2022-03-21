//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Ammar Ali on 3/9/21.
//

import Foundation

enum persistenceActionType{
    case add, remove
}

enum PersistenceManager{
    
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }

    
    static func updateWith(favorite: Follower, actionType: persistenceActionType, completed: @escaping (GFError?) -> Void ){
        retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                 var retrieveFavorites = favorites
                
                 switch actionType {
                 case .add:
                    guard !retrieveFavorites.contains(favorite) else{
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrieveFavorites.append(favorite)
                    
                    
                 case .remove:
                    retrieveFavorites.removeAll { $0.login == favorite.login }
                }
            
                completed(saveFavorites(favorites: retrieveFavorites))
                
            case .failure(let error):
            completed(error)
            }
            
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void){
        guard let favoritesData = defaults.object (forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
                  let decoder = JSONDecoder()
                  let favorites = try decoder.decode([Follower].self, from: favoritesData)
                  completed(.success(favorites))
              } catch {
                 completed(.failure(.invalidData))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        
        do{
            let encoder          = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch{
            return .unableToFavorite
        }
    }
    
}


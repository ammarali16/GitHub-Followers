//
//  GFError.swift
//  GHFollowers
//
//  Created by Ammar Ali on 2/18/21.
//

import Foundation

enum GFError: String,Error {
    
    case invalidUsername    = "This username created an invalid request. Please try agian."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server"
    case invalidData        = "The data received from thr server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You have already favorited this user."
}

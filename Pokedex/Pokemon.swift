//
//  Pokemon.swift
//  Pokedex
//
//  Created by Manuel S. Gomez on 12/14/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height:String!
    private var _weight: String!
    private var _attack:String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL:String!
    
    //With this we never return nils, just empty strings. This avoids crashes.
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name:String {
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = String(defense)
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1{
                        for x in 1..<types.count{
                            if let name = types[x]["name"] {
                                self._type! += " / \(name.capitalized)"
                            }
                        }
                    }
                }else{
                    self._type = "N/A"
                }
                
                /*
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] , descriptions.count > 0{
                    for x in 0..<descriptions.count{
                        if let url = descriptions[x]["resource_uri"]{
                            //print(url)
                            self.downloadPokemonDescription(URL: url)
                        }
                    }
                }*/
                
            }
            //We complete the request so the closure takes action where it was called
            completed()
            
        }
        
    }
    
    /*
    
    func downloadPokemonDescription(URL:String){
        
        let descriptionURL = "\(URL_BASE)\(URL)"
        
        Alamofire.request(descriptionURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> , dict.count > 0{
                if let description = dict["description"] as? String {
                    self._description? += " / \(description.capitalized)"
                }
            }
            //completed()
        }
    }*/
    
}




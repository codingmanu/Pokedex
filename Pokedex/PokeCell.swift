//
//  PokeCell.swift
//  Pokedex
//
//  Created by Manuel S. Gomez on 12/14/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell{

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
        layer.borderColor = UIColor(red: 165, green:165, blue:165, alpha: 0.5).cgColor
        layer.borderWidth = 1.0
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLabel.text = pokemon.name
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    

}

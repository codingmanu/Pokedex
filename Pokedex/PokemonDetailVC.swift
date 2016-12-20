//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Manuel S. Gomez on 12/15/16.
//  Copyright © 2016 Manuel S. Gomez. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    var pokemon:Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name

        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        currentEvoImage.image = img
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = String(pokemon.pokedexId)
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        
        if pokemon.nextEvolutionId == ""{
            evoLabel.text = "No evolutions"
            
        }else{
            evoLabel.text = "Next evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLvl)"
            let evoImg = UIImage(named: "\(pokemon.nextEvolutionId)")
            nextEvoImage.image = evoImg
        }
        
        
        
        

    }
}

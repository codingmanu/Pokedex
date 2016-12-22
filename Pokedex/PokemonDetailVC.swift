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
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var nextEvoButton: UIButton!
    
    var pokemon:Pokemon!
    var pokemonEvo:Pokemon?
    var pokemon2Evo: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    @IBAction func nextEvoButtonTapped() {
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemonEvo)
    }
    
    func updateUI(){
        nameLabel.text = pokemon.name
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = String(pokemon.pokedexId)
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        currentEvoImage.image = img
        
        if pokemon.nextEvolutionId == ""{
            evoLabel.text = "No evolutions"
            
        }else{
            evoLabel.text = "Next evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLvl)"
            let evoImg = UIImage(named: "\(pokemon.nextEvolutionId)")
            nextEvoButton.setBackgroundImage(evoImg, for: UIControlState.normal)
        }
        
        if pokemon.nextEvolutionId.characters.count == 0 {
            nextEvoButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.pokemonEvo != nil{
            if segue.identifier == "PokemonDetailVC"{
                if let detailsVC = segue.destination as? PokemonDetailVC{
                    if let poke = sender as? Pokemon {
                        detailsVC.pokemon = poke
                        poke.downloadPokemonDetails {
                            detailsVC.updateUI()
                            if poke.nextEvolutionId.characters.count > 0{
                                detailsVC.pokemonEvo = self.pokemon2Evo
                            }
                        }
                    }
                }
            }
        }
    }
}

// Project: PolavaramRohan-HW5
// EID: rp34586
// Course: CS329E
//  PizzaViewCOntroller.swift
//
//
//  Created by Rohan Polavaram on 10/12/23.
//

import UIKit
import CoreData

protocol PizzaViewControllerDelegate: AnyObject {
    func addPizzaToPizzaList(_ pizza: Pizza)
}

class PizzaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedCrust: String = ""
    var selectedCheese: String = ""
    var selectedMeat: String = ""
    var selectedVeggies: String = ""
    var pizzaSize: String = "Small"
    var cellVisible: Bool = false
    var done:Bool = false
    var finalPizza: Pizza = Pizza(pSize: "", crust: "", cheese: "", meat: "", veggies: "")
    
    weak var delegate: PizzaViewControllerDelegate?
    
    @IBOutlet weak var pizzaCreatorTable: UITableView!
    @IBOutlet weak var sizeController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaCreatorTable.delegate = self
        pizzaCreatorTable.dataSource = self
        pizzaCreatorTable.delegate = self
        pizzaCreatorTable.dataSource = self
        pizzaCreatorTable.isHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath)
        
        
        cell.textLabel?.text = "Size: \(pizzaSize)"
        cell.detailTextLabel?.text = "Crust: \(selectedCrust)\nCheese: \(selectedCheese)\nMeat: \(selectedMeat)\nVeggies: \(selectedVeggies)"
        
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.numberOfLines = 4
        
        return cell
    }
    @IBAction func selectCrustButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Crust", message: "Choose the crust type:", preferredStyle: .alert)

                let thinCrustAction = UIAlertAction(title: "Thin Crust", style: .default) { _ in
                    self.selectedCrust = "Thin Crust"
                    self.pizzaCreatorTable.reloadData()
                }

                let thickCrustAction = UIAlertAction(title: "Thick Crust", style: .default) { _ in
                    self.selectedCrust = "Thick Crust"
                    self.pizzaCreatorTable.reloadData()
                }

                alert.addAction(thinCrustAction)
                alert.addAction(thickCrustAction)

                present(alert, animated: true, completion: nil)
        
    }
    @IBAction func selectCheeseButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)

                let regularCheeseAction = UIAlertAction(title: "Regular Cheese", style: .default) { _ in
                    self.selectedCheese = "Regular Cheese"
                    self.pizzaCreatorTable.reloadData()
                }

                let noCheeseAction = UIAlertAction(title: "No Cheese", style: .default) { _ in
                    self.selectedCheese = "No Cheese"
                    self.pizzaCreatorTable.reloadData()
                }

                let doubleCheeseAction = UIAlertAction(title: "Double Cheese", style: .default) { _ in
                    self.selectedCheese = "Double Cheese"
                    self.pizzaCreatorTable.reloadData()
                }

                actionSheet.addAction(regularCheeseAction)
                actionSheet.addAction(noCheeseAction)
                actionSheet.addAction(doubleCheeseAction)

                present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func selectMeatButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Meat", message: "Choose one meat:", preferredStyle: .actionSheet)

                let pepperoniAction = UIAlertAction(title: "Pepperoni", style: .default) { _ in
                    self.selectedMeat = "Pepperoni"
                    self.pizzaCreatorTable.reloadData()
                }

                let sausageAction = UIAlertAction(title: "Sausage", style: .default) { _ in
                    self.selectedMeat = "Sausage"
                    self.pizzaCreatorTable.reloadData()
                }

                let canadianBaconAction = UIAlertAction(title: "Canadian Bacon", style: .default) { _ in
                    self.selectedMeat = "Canadian Bacon"
                    self.pizzaCreatorTable.reloadData()
                }

                actionSheet.addAction(pepperoniAction)
                actionSheet.addAction(sausageAction)
                actionSheet.addAction(canadianBaconAction)

                present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func selectVeggiesButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Veggies", message: "Choose your veggies:", preferredStyle: .actionSheet)

                let mushroomAction = UIAlertAction(title: "Mushroom", style: .default) { _ in
                    self.selectedVeggies = "Mushroom"
                    self.pizzaCreatorTable.reloadData()
                }

                let onionAction = UIAlertAction(title: "Onion", style: .default) { _ in
                    self.selectedVeggies = "Onion"
                    self.pizzaCreatorTable.reloadData()
                }

                let greenOliveAction = UIAlertAction(title: "Green Olive", style: .default) { _ in
                    self.selectedVeggies = "Green Olive"
                    self.pizzaCreatorTable.reloadData()
                }

                let blackOliveAction = UIAlertAction(title: "Black Olive", style: .default) { _ in
                    self.selectedVeggies = "Black Olive"
                    self.pizzaCreatorTable.reloadData()
                }

                let noneAction = UIAlertAction(title: "None", style: .default) { _ in
                    self.selectedVeggies = "None"
                    self.pizzaCreatorTable.reloadData()
                }

                actionSheet.addAction(mushroomAction)
                actionSheet.addAction(onionAction)
                actionSheet.addAction(greenOliveAction)
                actionSheet.addAction(blackOliveAction)
                actionSheet.addAction(noneAction)

                present(actionSheet, animated: true, completion: nil)
    }

    
    @IBAction func pizzaSizeSelector(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex

        switch selectedSegmentIndex {
        case 0:
            pizzaSize = "Small"
            pizzaCreatorTable.reloadData()
        case 1:
            pizzaSize = "Medium"
            pizzaCreatorTable.reloadData()
        case 2:
            pizzaSize = "Large"
            pizzaCreatorTable.reloadData()
        default:
            break
        }
    }
    @IBAction func done(_ sender: Any) {
        if selectedCrust.isEmpty {
            let missingFieldsAlert = UIAlertController(title: "Missing Ingredients", message: "Please select a crust", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(okAction)
            present(missingFieldsAlert, animated: true, completion: nil)
        }else if selectedCheese.isEmpty {
            let missingFieldsAlert = UIAlertController(title: "Missing Ingredients", message: "Please select a cheese type", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(okAction)
            present(missingFieldsAlert, animated: true, completion: nil)
            
        }else if selectedMeat.isEmpty {
            let missingFieldsAlert = UIAlertController(title: "Missing Ingredients", message: "Please select a meat", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(okAction)
            present(missingFieldsAlert, animated: true, completion: nil)
            
        }else if selectedVeggies.isEmpty {
            let missingFieldsAlert = UIAlertController(title: "Missing Ingredients", message: "Please select a veggie", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(okAction)
            present(missingFieldsAlert, animated: true, completion: nil)
        } else {
            let tempPizza = Pizza(pSize: pizzaSize, crust: selectedCrust, cheese: selectedCheese, meat: selectedMeat, veggies: selectedVeggies)
            finalPizza = tempPizza
            pizzaCreatorTable.isHidden = false
            done = true
            
        }
    }
    @IBAction func back(_ sender: Any) {
        if done {
            delegate?.addPizzaToPizzaList(finalPizza)
        }
        dismiss(animated: true, completion: nil)
    }
}

// Project: PolavaramRohan-HW5
// EID: rp34586
// Course: CS329E
//  ViewController.swift
//  PolavaramRohan-HW5
//
//  Created by Rohan Polavaram on 10/12/23.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext


class ViewController: UIViewController, UITableViewDataSource, PizzaViewControllerDelegate {
    var pizzaList: [Pizza] = []
    
    @IBOutlet weak var tableView: UITableView!
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        let array = loadCoreData()
        for pizza in array{
            if let pizzaCheese = pizza.value(forKey: "cheese"){
                if let pizzaMeat = pizza.value(forKey: "meat"){
                    if let pizzaVeggies = pizza.value(forKey: "veggies"){
                        if let pizzaCrust = pizza.value(forKey: "crust"){
                            if let pizzaSize = pizza.value(forKey: "pSize"){
                                pizzaList.append(Pizza(pSize: pizzaSize as! String, crust: pizzaCrust as! String, cheese: pizzaCheese as! String, meat: pizzaMeat as! String, veggies: pizzaVeggies as! String))
                            }
                        }
                    }
                }
            }
            
        }
                    
    }
    
    func loadCoreData() -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizzas")
        var fetchedResults: [NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch{
            print("Error occured while retriving data")
            abort()
        }
        return (fetchedResults)!
    }
    
    func storePizza(pizza: Pizza){
        let storedPizza = NSEntityDescription.insertNewObject(forEntityName: "Pizzas", into: context)
        storedPizza.setValue(pizza.cheese, forKey: "cheese")
        storedPizza.setValue(pizza.meat, forKey: "meat")
        storedPizza.setValue(pizza.veggies, forKey: "veggies")
        storedPizza.setValue(pizza.crust, forKey: "crust")
        storedPizza.setValue(pizza.pSize, forKey: "pSize")
        saveContext()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pizzaList.remove(at: indexPath.row)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizzas")
            var fetchedResults:[NSManagedObject]
            do{
                try fetchedResults = context.fetch(request) as! [NSManagedObject]
                context.delete(fetchedResults[indexPath.row])
                saveContext()
            }catch{
                print("Error occured while deleting data")
                abort()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath)
        
        let pizza = pizzaList[indexPath.row]
        
        cell.textLabel?.text = "Size: \(pizza.pSize)"
        cell.detailTextLabel?.text = "Crust: \(pizza.crust)\nCheese: \(pizza.cheese)\nMeat: \(pizza.meat)\nVeggies: \(pizza.veggies)"
        
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.numberOfLines = 4
        
        return cell
    }
    @IBAction func addPizzaPressed(_ sender: Any) {
        let pizzaVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PizzaViewController") as! PizzaViewController
            pizzaVC.delegate = self
            present(pizzaVC, animated: true, completion: nil)
    }
    
    func addPizzaToPizzaList(_ pizza: Pizza) {
        pizzaList.append(pizza)
        storePizza(pizza: pizza)
        tableView.reloadData() 
    }
    @IBAction func signOutButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SignOutSegue", sender: nil)
    }
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


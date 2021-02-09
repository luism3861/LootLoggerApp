//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Luis Eduardo Madina Huerta on 09/11/20.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton){
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row:index,section:0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
    }   
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
        if isEditing == true{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true);
        }else{
            sender.setTitle("Done",for:.normal)
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65    
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath){
        
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int{
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"

        if item.valueInDollars <= 50 {
            cell.valueLabel.textColor = hexStringToUIColor(hex: "#e83120")
            
            
            
            
            
            
            
            
            
            
            
        }else{
            cell.valueLabel.textColor = hexStringToUIColor(hex: "#04bf1d")
            
        }
        cell.updateConstraintsIfNeeded()

        return cell
    } 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

       
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

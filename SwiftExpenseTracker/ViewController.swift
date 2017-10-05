//
//  ViewController.swift
//  SwiftExpenseTracker
//
//  Created by Garrett Barker on 10/4/17.
//  Copyright © 2017 Garrett Barker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var myTable: UITableView!
    
    var dataInfo: [Payments] = []
    var selectedObject: [Payments] = []
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return (dataInfo.count)
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = dataInfo[indexPath.row].name
        cell.detailTextLabel?.text = "$" + String(format:"%.2f", dataInfo[indexPath.row].amount!)
     return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = [dataInfo[indexPath.row]]
        performSegue(withIdentifier: "addSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
        print(dataInfo as Any)
    }

    func getData() -> Void {
        do{
            dataInfo = try context.fetch(Payments.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewControllerSecond
        vc.dataInfo = selectedObject
        selectedObject.removeAll()
    }
    
    public func reloadTable(){
        getData()
        myTable.reloadData()
    }

}


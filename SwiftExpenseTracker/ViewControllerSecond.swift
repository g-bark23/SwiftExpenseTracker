//
//  ViewControllerSecond.swift
//  SwiftExpenseTracker
//
//  Created by Garrett Barker on 10/4/17.
//  Copyright © 2017 Garrett Barker. All rights reserved.
//

import UIKit

class ViewControllerSecond: UIViewController {

    @IBOutlet var nameOfPlace: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var category: UITextField!
    @IBOutlet var formOfPayment: UITextField!
    @IBOutlet var date: UIDatePicker!
    
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    var dataInfo: [Payments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let saveBTN = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.save, target:self,
                                      action: #selector(saveButtonTapped(_:)))
        let deleteBTN = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.trash, target:self,
                                      action: #selector(deleteButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [saveBTN, deleteBTN]
        
        if !dataInfo.isEmpty {
            nameOfPlace.text = dataInfo[0].name
            let fmt = NumberFormatter()
            amount.text = fmt.string(from: dataInfo[0].amount!)
            category.text = dataInfo[0].category
            formOfPayment.text = dataInfo[0].formOfPayment
            date.date = dataInfo[0].date!
        }
    }

    @objc func saveButtonTapped(_ sender: UIButton){
        if !dataInfo.isEmpty{
            let data = dataInfo[0]
            data.name = nameOfPlace.text
            data.amount = Decimal(string: amount.text!)! as NSDecimalNumber
            data.category = category.text
            data.formOfPayment = formOfPayment.text
            data.date = date.date
        }
        else{
            let data = Payments(context: context)
            data.name = nameOfPlace.text
            data.amount = Decimal(string: amount.text!)! as NSDecimalNumber
            data.category = category.text
            data.formOfPayment = formOfPayment.text
            data.date = date.date
        }
        
        do {
            try context.save()
            ViewController().reloadTable()
            _ = navigationController?.popViewController(animated: true)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton){
        if !dataInfo.isEmpty{
            let data = dataInfo[0]
            context.delete(data)
            
            do {
                try context.save()
                ViewController().reloadTable()
                _ = navigationController?.popViewController(animated: true)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

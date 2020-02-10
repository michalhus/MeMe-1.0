//
//  SentMemesTableVC .swift
//  Meme 1.0
//
//  Created by Michal Hus on 2/10/20.
//  Copyright © 2020 Michal Hus. All rights reserved.
//

import Foundation

import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController      UITableViewDataSource, UITableViewDelegate

class SentMemesTableVC:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //   TODO: Create a property called memes, and set it to the memes array from the AppDelegate.
    
    // MARK: Properties
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var memes = appDelegate.memes
    
    let allVillains = Villain.allVillains
//    var memes: [Meme]! {
//        let object = UIApplication.shared.delegate
//        let appDelegate = object as! AppDelegate
//        return appDelegate.memes
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allVillains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlySentMeme")!
        let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = villain.name
        cell.imageView?.image = UIImage(named: villain.imageName)
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Table View Data Source
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.memes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlySentMeme")!
//        let meme = self.memes[(indexPath as NSIndexPath).row]
//        let villain = self.allVillains[(indexPath as NSIndexPath).row]
//
//        print(meme)
//        print(memes.count)
//        // Set the name and image
////        cell.textLabel?.text = meme.topText
////        cell.imageView?.image = UIImage(named: meme.memedImage)
//
//        // Set the name and image
//        cell.textLabel?.text = villain.name
//        cell.imageView?.image = UIImage(named: villain.imageName)
//
//
//        // If the cell has a detail label, we will put the evil scheme in.
////        if let detailTextLabel = cell.detailTextLabel {
////            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
////        }
//
//        return cell
//    }

////    This is for selecting VillainDetailViewController
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
//        self.navigationController!.pushViewController(detailController, animated: true)
//    }

}


//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VillainCell")!
//        let villain = self.allVillains[(indexPath as NSIndexPath).row]
//
//        // Set the name and image
//        cell.textLabel?.text = villain.name
//        cell.imageView?.image = UIImage(named: villain.imageName)
//
//        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
//
//        return cell
//    }

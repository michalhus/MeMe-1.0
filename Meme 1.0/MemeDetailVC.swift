//
//  MemeDetailVC.swift
//  Meme 1.0
//
//  Created by Michal Hus on 2/11/20.
//  Copyright © 2020 Michal Hus. All rights reserved.
//

import UIKit

// MARK: - VillainDetailViewController: UIViewController

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties
    var meme: Meme!
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

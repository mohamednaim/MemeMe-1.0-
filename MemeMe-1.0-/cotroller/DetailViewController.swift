//
//  DetailViewController.swift
//  MemeMe-1.0-
//
//  Created by mohamed on 1/14/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var memes:Meme!
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        memeImage.image = memes.memedImage
        
        self.tabBarController?.tabBar.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

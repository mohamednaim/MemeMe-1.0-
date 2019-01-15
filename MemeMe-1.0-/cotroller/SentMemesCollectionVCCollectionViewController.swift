//
//  SentMemesCollectionVCCollectionViewController.swift
//  MemeMe-1.0-
//
//  Created by mohamed on 1/14/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit


class SentMemesCollectionVCCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
       @IBOutlet weak var cellImageView: UIImageView!
    var memes:[Meme]{
        
        return(UIApplication.shared.delegate as!AppDelegate).memes
        
    }
let reuseIdentifier="CollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
          navigationItem.title = "Sent Memes"
           setDefaultState()
        // Do any additional setup after loading the view.
    }
    private func setDefaultState(){
        let space:CGFloat
        let dimention:CGFloat
        if (UIDevice.current.orientation.isPortrait) {
            space = 1.0
            dimention = (view.frame.size.width - (1 * space)) / 5
        }else{
            space = 2.0
            dimention = (view.frame.size.width - (2 * space)) / 3
        }
        flowLayout.minimumLineSpacing=space
        flowLayout.minimumInteritemSpacing=space
        flowLayout.itemSize=CGSize(width: dimention, height: dimention	)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

  


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as!CollectionCell
        //set image
        let image = memes[indexPath.row]
        cell.cellImageView?.image=image.memedImage
        
    
        // Configure the cell
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //grab the detialsVcFrom StoryBord
        let detialController=self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")as!DetailViewController
        let me = memes[(indexPath as NSIndexPath).row]
        //populated view controller with data from the selected item
        detialController.memes=me
        navigationController!.pushViewController(detialController, animated: true)
        
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

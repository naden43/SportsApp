//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Naden on 11/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {

    @IBOutlet weak var playerCollectionView: UICollectionView!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerCollectionView.dataSource = self
        playerCollectionView.delegate = self
        
        /*playerCollectionView.register(CustomCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")*/

        let layout = UICollectionViewCompositionalLayout{
            (section , enviroment) in
            
            let section = self.drawSection()
            /*let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]*/
            return section
        }
        playerCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func drawSection()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.3))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
           /*let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]*/
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        
    
        
        
        return cell
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
   //collection error in header
    
    
    /*func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? CustomCollectionReusableView
        
           //header?.sectionImage.image = .add
            if indexPath.section == 0{
                //header?.sectionTitle = UILabel()
                //header?.sectionTitle.text = "player"
                header?.title = "players"
            }
            else
            {
                //header?.sectionTitle.text = "Coaches"
            }
        
        //header?.backgroundColor = .red
        //header.sectionTitle.text = "yes"
        
        
        return header!
    }*/
    
}

//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by Findl MAC on 07/03/2019.
//  Copyright © 2019 Findl MAC. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    
    var videos: [Video]?
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()

        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    func fetchVideos() {
        ApiService.sharedinstance.fetchVideo { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videLauncher = VideoLauncher()
        videLauncher.showVideoPlayer()
    }
}

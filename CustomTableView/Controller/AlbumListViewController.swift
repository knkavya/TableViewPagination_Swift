//
//  AlbumListViewController.swift
//  CustomTableView
//
//  Created by Kavya KN on 15/07/21.
//

import UIKit

class AlbumListViewController: UIViewController, DeleteData {
    
    @IBOutlet weak var albumTableView: UITableView!
    
    // MARK: Parameters used for Pagination or Infinite Scroll.
    var dataLoadLimit = 10
    var totalAlbums = 0
    var index = 0
    
    let parser = Parser()
    
    var albums = [Album]()
    var displayAlbums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetUp()
        self.loadDataFromApiToDataArray()
    }
    
    func tableViewSetUp(){
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.separatorStyle = .none
    }
    
    // MARK: Logic for getting all albums data and assign based on display limit.
    func loadDataFromApiToDataArray(){
        let loader = self.showLoader()
        parser.parse {
            data in
            self.albums = data
            self.totalAlbums = self.albums.count
            while self.index<self.dataLoadLimit
            {
                self.displayAlbums.append(self.albums[self.index])
                self.index = self.index + 1
            }
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
        }
        self.hideLoader(loader: loader)
    }
}

// MARK: UITableView DataSource and Delegate methods.
extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        
        let album = self.displayAlbums[indexPath.row]
        cell.avatarImage.load(urlString: album.thumbnailURL)
        cell.titleLabel.text = album.title.capitalizingFirstLetter()
        
        return cell
    }
    
    // MARK: Logic for loading next 10 cells when we scroll table view to last visible index.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row == self.displayAlbums.count - 1) {
            var index = self.displayAlbums.count - 1
            if index + 10 > self.albums.count - 1 {
                self.dataLoadLimit = self.albums.count - index
            } else {
                self.dataLoadLimit = index + 10
            }
            while index < self.dataLoadLimit {
                self.displayAlbums.append(self.albums[index])
                index = index + 1
            }
            self.perform(#selector(self.loadAlbumsInTable), with: nil, afterDelay: 0.5)
        }
        
    }
    
    @objc func loadAlbumsInTable() {
        DispatchQueue.main.async {
            self.albumTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        let album = self.displayAlbums[indexPath.row]
        detailVC.imageUrl = album.thumbnailURL
        detailVC.selectedAlbumIndex = indexPath
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension AlbumListViewController {
    
    // MARK: Callback method to delete the selected index and refresh table data.
    func deleteSelectedDataInTableView(index: IndexPath) {
        self.displayAlbums.remove(at: index.row)
        self.albumTableView.reloadData()
    }
}


//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Nicole Souvenir on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import UIKit
import Foundation


//1. create protocol
protocol FileManagerDelegate: class {
    func didRefresh(_ service: FileManagerHelper, favoriteImage: [UIImage])
}

class FileManagerHelper {
    private init() {}
    static let manager = FileManagerHelper()
    
    var pathName = "favorites.plist"
    
    //2. Instantiate delegate
    var delegate: FileManagerDelegate?
    
    //MARK: object being persisted
    private var favoriteImages = [UIImage]()
    
    private var favoriteURLS = [String]() {
        didSet {
            saveFavoriteImageToSandBox()
        }
    }
    
    //returns documents directory path for app sandbox
    private func documentsDirectory() -> URL {
        //this is finding the document folder in the app
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //return document folder url path
        print(paths)
        return paths[0]
    }
    
    //returns the path for supplied name from the documents directory
    private func dataFilePath(withPathName path: String) -> URL {
        //now you can write to the file/pathName you pass in! (If the file name doesn't exsist, it will create it)
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    /////////////////////Loading, adding, getting, deleting favorite urls
    
    func addFavoriteImageToFileManager(from urlstr: String) {
        favoriteURLS.append(urlstr)
    }
    
    //MARK: Saving favorites: This saves the array of Favorites to the phone
    private func saveFavoriteImageToSandBox() {
        //Save URLs
        let path = dataFilePath(withPathName: pathName) //getting path where image url is going to be stored
        do {
            let data = try PropertyListEncoder().encode(favoriteURLS)//encoding urls to data
            try data.write(to: path, options: .atomic) //writing data to sandbox
            loadFavorites()// takes loaded UIImages
            //3. Call delegate here
            self.delegate?.didRefresh(self, favoriteImage: self.favoriteImages)
        }
        catch {
            print("WHYYYYYYYYY")
        }
    }
    
    //MARK: Get favorites images to VC from FM : This will set the favorited object in favorites VC the image object in File Manager
    func getFavoriteImagesFromFileManager() -> [UIImage]{
        return favoriteImages
    }
    
    //MARK: Called in the app delegate to bring up all favorited images
    func loadFavoritesFromSandBox() {//Bringing back from sandbox so need to decode back url strings
        //Save URLs
        let path = dataFilePath(withPathName: pathName)
        do {
            let data = try Data.init(contentsOf: path)
            let arrayOfFavoritedImageUrlStrings = try PropertyListDecoder().decode([String].self, from: data)
            self.favoriteURLS = arrayOfFavoritedImageUrlStrings
        }
        catch {
            print("loadFavoritesFromSandBox error decoding items: \(error.localizedDescription)")
        }
    }
    
    //MARK: called when the favorites VC view loads : goes through all image urls and if it's an UIImage adds to array
    func loadFavorites() {
        var arrayOfFavorites = [UIImage]()
        for imageURLS in favoriteURLS {
            if let loadedimage = getImage(with: imageURLS){//if loaded image is an image made from an image url add to array
                arrayOfFavorites.append(loadedimage)
            } else {
                print("No image with that name saved on phone")
            }
        }
        self.favoriteImages = arrayOfFavorites
    }
    
    
    //MARK: deleting one image from tableview
    func removeFavorite(from index: Int) {
        favoriteImages.remove(at: index)
    }
    
    
    //MARK: deleting one image url
    func deleteFavImage(favPathName: String) {
        let imageURL = dataFilePath(withPathName: favPathName) // let the Image URL get the file path name where it is stored in the phone
        do {
            try FileManager.default.removeItem(at: imageURL) //try to remove that URL at the place it is stord in the phone
        } catch {
            print("error removing: \(error.localizedDescription)")
        }
        var indexCounter = 0
        if favoriteURLS.contains(favPathName) {// if the [URLString] contains that filePathName
            for savedImageURL in favoriteURLS {//iterate thru
                if savedImageURL == favPathName {//if that saved image URL steing matches the path name that it's supposed to be saved under
                    favoriteURLS.remove(at: indexCounter) // remove that URL from the sandbox
                }
                indexCounter += 1 //move onto the next index to do the check
            }
        }
    }
    
    ///////////////////SAVING AND GETTING IMAGES
    
    //MARK: Saving Images to disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print("save image error: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: Getting images from disk: gets image urls and converts them into data
    public func getImage(with urlStr: String) -> UIImage? { //turns image url into an UIImage
        do {
            let imagePathName = urlStr.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print("error getting images \(error.localizedDescription)")
            return nil
        }
    }
}



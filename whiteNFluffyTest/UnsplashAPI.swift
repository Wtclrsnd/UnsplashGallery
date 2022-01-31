//
//  UnsplashAPI.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 01.02.2022.
//

import UIKit

final class UnsplashAPI {
        
    class func getRandomPhoto(request: URLRequest, completion: @escaping (_ photos: [Photo]) -> Void) {
        UnsplashAPI.makeGETRequest(request: request, completion: { photos in
            DispatchQueue.main.async {
                completion(photos)
            }
        })
    }
    
    class func likePhoto() {}
    
    class func unlikePhoto() {}
    
    // MARK: important (!)
    
    private class func makeGETRequest(request: URLRequest, completion: @escaping (_ photos: [Photo]) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            guard error == nil else {
                print(String(describing: error?.localizedDescription))
                return
            }
            guard let data = data else {
                return
            }
            
            print(data)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let responseObject = try jsonDecoder.decode(
                    [RandomPhotoResponse].self,
                    from: data
                )
                var photos = [Photo]()
                for i in responseObject{
                    let photo = Photo(url: i.urls?.full, author: i.user?.name, likes: i.likes, likedByUser: false)
                    photos.append(photo)
                }
                    completion(photos)
                
            } catch let error {
                print(String(describing: error.localizedDescription))
            }
        }).resume()

    }
    
    private class func makePOSTRequest() {}
}

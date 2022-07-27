

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTubBar()
        setUpVSs()
    }
    
    private func setUpTubBar() {
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.isTranslucent = true
        self.tabBar.alpha = 0.94
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
    private func setUpVSs() {
        viewControllers = [
            createNavController(for: CitiesViewController(), title: "Home", image: UIImage(systemName: "mappin.and.ellipse")!, selectedImage: nil),
        ]
        
    }
    
    
}








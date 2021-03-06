

import Foundation
import UIKit
import AVKit

final class SplashViewController: UIViewController {
    
    internal var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavBar()
        self.view.backgroundColor = UIColor.white
        self.playVideo()
        self.configurePlayerObserver()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "splash", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        player.isMuted = true
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configurePlayerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.player.currentItem)
    }
    
    @objc internal func playerDidFinishPlaying() {
        self.navigateHome()
    }
    
    private func navigateHome() {
        let exploreVC = UINavigationController(rootViewController: DoorPersonViewController())
        self.present(exploreVC, animated: false, completion: nil)
    }
    
}

//
//  MediaViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 21.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit
import AVFoundation

class MediaViewController : UIViewController {

    let music = ["Queen"]

    private lazy var playBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "play"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(play), for: .touchUpInside)
        return btn
    }()

    var Player = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media Player"
        view.backgroundColor = .white

        do {
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: music[0], ofType: "mp3")!))
            Player.prepareToPlay()
        }
        catch {
            print(error)
        }

        view.addSubview(playBtn)

        NSLayoutConstraint.activate([
            playBtn.heightAnchor.constraint(equalToConstant: 44),
            playBtn.widthAnchor.constraint(equalToConstant: 44),
            playBtn.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            playBtn.centerYAnchor.constraint(equalTo: super.view.centerYAnchor)
        ])


    }

    @objc
    func play(){
        if Player.isPlaying {
            Player.pause()
            playBtn.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            Player.play()
            playBtn.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }

//    @objc func StopButton() {
//            if Player.isPlaying {
//                Player.stop()
//                Player.currentTime = .zero
//            }
//            else {
//                print("Already stopped!")
//            }
//        }
}
